# Provides a specialized version of buildEnv, designed specifically for ROS
# packages. It is useful when using a large number of ROS packages that would
# otherwise cause ROS_PACKAGE_PATH or other environment variables to become too
# long.
#
# All ROS and Python packages in the 'paths' closure are added to the
# environment, while other packages are propagated. This makes it usable in
# nix-shell, while preventing ROS_PACKAGE_PATH and CMAKE_PREFIX_PATH from
# becoming too large due to a huge number of ROS packages.
#
# By default, all binaries in the environment are wrapped, setting the relevant
# ROS environment variables, allowing use outside of nix-shell.
# Wrapping prefixes the existing variables with the buildEnv output, which
# ensures reproducibility and prevents an incompatible user environment from
# breaking the Nix setup. However, for development environments used within
# mkShell, it is often desirable for packages in the local ROS workspace to
# take precedence over Nix-built packages. This can be achieved by setting
# underlay to true.
{ lib, stdenv, buildPackages, writeText, buildEnv, makeWrapper, python3, ros-environment
, runCommand, ament-package ? null }:
{ paths ? [], wrapPrograms ? true, underlay ? false, postBuild ? "", passthru ? { }, ... }@args:

with lib;
assert assertMsg (underlay -> wrapPrograms)
  "Setting underlay without wrapPrograms has no effect.";
let
  propagatePackages = packages: let
    validPackages = filter (d: d != null) packages;
    partitionedPackages = partition (d: (d.rosPackage or false) || (hasAttr "pythonModule" d)) validPackages;
    rosPackages = partitionedPackages.right;
    otherPackages = partitionedPackages.wrong;
    rosPropagatedPackages = unique (concatLists (
      catAttrs "propagatedBuildInputs" rosPackages ++
      catAttrs "rosBuildExportDepends" rosPackages ++
      catAttrs "rosExecDepends" rosPackages));
    recurse = propagatePackages rosPropagatedPackages;
  in if length validPackages == 0 then {
      rosPackages = [];
      otherPackages = [];
    } else {
      rosPackages = unique (rosPackages ++ recurse.rosPackages);
      otherPackages = unique (otherPackages ++ recurse.otherPackages);
    };

  propagatedPaths = propagatePackages paths;

  xfix = if underlay then "suffix" else "prefix";

  # The non-ROS packages are propagated rather than merged into the
  # environment, so setup-sh adds their closure explicitly.
  otherClosure = map (i: i.drv) (builtins.genericClosure {
    startSet = map (d: { key = d.outPath; drv = d; }) propagatedPaths.otherPackages;
    operator = { drv, ... }: map (d: { key = d.outPath; drv = d; })
      (filter (d: d != null && d ? outPath) (drv.propagatedBuildInputs or [ ]));
  });

  amentTemplates = optionalString (ament-package != null)
    "${ament-package}/${python3.sitePackages}/ament_package/template/prefix_level";

  # A plain script to source, for using the environment without nix develop.
  setup-sh = runCommand "ros-env-setup.sh" {
    nativeBuildInputs = [ buildPackages.python3 ];
  } ''
    python3 ${./render-setup-sh.py} > $out \
      --env ${env} \
      --site-packages ${python3.sitePackages} \
      --bash ${buildPackages.bash}/bin/bash \
      --set ROS_DISTRO '${ros-environment.rosDistro}' \
      --set ROS_VERSION '${toString ros-environment.rosVersion}' \
      --set ROS_PYTHON_VERSION '${lib.versions.major python3.version}' \
      --set NIX_BINTOOLS_WRAPPER_TARGET_HOST_${stdenv.cc.bintools.suffixSalt} 1 \
      --set NIX_CC_WRAPPER_TARGET_HOST_${stdenv.cc.suffixSalt} 1 \
      ${concatMapStringsSep " " (d: concatMapStringsSep " " (o: d.${o}) (d.outputs or [ "out" ])) otherClosure}
  '';

  env = (buildEnv ((removeAttrs args [ "underlay" "wrapPrograms" ]) // {
    name = "ros-env";
    # Only add ROS packages to environment. The rest are propagated like normal.
    # ROS packages propagate a huge number of dependencies, which are added all
    # added to the environment with nix-shell -p, but would not normally not be
    # added with buildEnv. This file adds all specified ROS packages and their
    # ROS dependencies to the environment, while propagating other packages like
    # nix-shell -p does.
    paths = propagatedPaths.rosPackages;

    derivationArgs = {
      nativeBuildInputs = optional wrapPrograms makeWrapper;
      propagatedBuildInputs = propagatedPaths.otherPackages;

      # Disable redundant fixup operations.
      # The fixupPhase is needed for shell hooks and input propagation, but other
      # things like RPATH shrinking and shebang patching are not needed, as the
      # original packages should have already been fixed up.
      dontPatchELF = true;
      noAuditTmpdir = true;
      dontGzipMan = true;
      dontPatchShebangs = true;
      dontMoveLib64 = true;

      # nixpkgs's buildEnv disables substitutes, which can lead to
      # unnecessarily long build times for development environments.
      allowSubstitutes = true;
    };

    postBuild = postBuild + optionalString (ament-package != null) ''
      # Make the environment an ament prefix, so it can be sourced like any
      # ROS 2 install space.
      if [ -d "$out/share/ament_index" ]; then
        chmod u+w "$out"
        rm -f "$out"/local_setup.* "$out"/_local_setup_util*.py "$out"/setup.*
        cp ${amentTemplates}/_local_setup_util.py ${amentTemplates}/local_setup.bash ${amentTemplates}/local_setup.zsh "$out/"
        substitute ${amentTemplates}/local_setup.sh.in "$out/local_setup.sh" \
          --subst-var-by CMAKE_INSTALL_PREFIX "$out" \
          --subst-var-by ament_package_PYTHON_EXECUTABLE "${python3.interpreter}"
      fi
    '' + ''
      "${buildPackages.perl}/bin/perl" "${./setup-hook-builder.pl}"
    '' + optionalString wrapPrograms ''
      if [ -d "$out/bin" ]; then
        find -L "$out/bin" -executable -type f -xtype l -print0 | \
        while IFS= read -r -d "" link; do
          file="$(readlink "$link")"
          rm "$link"
          # Remove unwrapped versions of binaries
          if [[ "$(basename "$link")" == .*-wrapped ]]; then continue; fi

          makeWrapper "$file" "$link" \
            --${xfix} PATH : "$out/bin" \
            --${xfix} LD_LIBRARY_PATH : "$out/lib" \
            --${xfix} PYTHONPATH : "$out/${python3.sitePackages}" \
            --${xfix} CMAKE_PREFIX_PATH : "$out" \
            --${xfix} AMENT_PREFIX_PATH : "$out" \
            --${xfix} ROS_PACKAGE_PATH : "$out/share" \
            --${xfix} GZ_CONFIG_PATH : "$out/share/gz" \
            --set ROS_DISTRO '${ros-environment.rosDistro}' \
            --set ROS_VERSION '${toString ros-environment.rosVersion}' \
            --set ROS_PYTHON_VERSION '${lib.versions.major python3.version}' \
            ''${rosWrapperArgs[@]}
        done
      fi
    '';

    passthru = passthru // {
      inherit setup-sh;
      env = stdenv.mkDerivation {
        name = "interactive-ros-env";

        buildInputs = [ env ];

        buildCommand = ''
          echo >&2 ""
          echo >&2 "*** ROS 'env' attributes are intended for interactive nix-shell sessions, not for building! ***"
          echo >&2 ""
          exit 1
        '';
      };
    };
  })).overrideAttrs ({ buildCommand, ...}: {
    # Hack to execute buildPhase and fixupPhase instead of just
    # buildCommand provided by nixpkgs buildEnv. We need fixupPhase
    # for shell hooks to set ROS env. variables and for input
    # propagation.
    buildCommand = null;
    oldBuildCommand = buildCommand;
    buildPhase = ''
      . $NIX_ATTRS_SH_FILE
      runHook preBuild
      eval "$oldBuildCommand"
      runHook postBuild
    '';
    phases = [ "buildPhase" "fixupPhase" ];
  });
in env
