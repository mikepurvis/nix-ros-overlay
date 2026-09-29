{ stdenv, lib, python3Packages, rosDistro, rosVersion, buildEnv }:
{ buildType ? "catkin"
  # Too difficult to fix all the problems with the tests in each package
, doCheck ? false
# nixpkgs requires that either dontWrapQtApps is set or wrapQtAppsHook is added
# to nativeBuildInputs if a package depends on Qt5. This is difficult to achieve
# with auto-generated packages, so we just always disable wrapping except for
# packages that are overridden in distro-overlay.nix. This means some Qt5
# applications are broken, but allows all libraries that depend on Qt5 to build
# correctly.
, dontWrapQtApps ? true
, nativeBuildInputs ? [ ]
, CXXFLAGS ? ""
, postFixup ? ""
, passthru ? { }
, separateDebugInfo ? true
# Put headers and CMake configs in a dev output, so that runtime environments,
# which only need out, don't carry them or the -dev outputs they refer to.
, splitDev ? rosVersion == 2 && buildType != "ament_python"
, preFixup ? ""
# ROS dependencies are not propagated. Instead, each package records which ROS
# packages it exports to dependents (<build_export_depend> and friends) and
# which it needs at runtime (<exec_depend>). Following colcon, a package is
# built against its direct dependencies plus their recursive runtime closure,
# and buildEnv follows the same lists to assemble environments.
, rosBuildExportDepends ? [ ]
, rosExecDepends ? [ ]
, propagatedBuildInputs ? [ ]
, buildInputs ? [ ]
, ...
}@args:

let
  isRos = d: d != null && (d.rosPackage or false);
  runDepends = d: lib.filter isRos ((d.rosBuildExportDepends or [ ])
    ++ (d.rosExecDepends or [ ]) ++ (d.propagatedBuildInputs or [ ]));
  # Keyed by name rather than outPath, since exec_depends may form cycles.
  rosBuildClosure = lib.filter (d: (d.pname or null) != (args.pname or null))
    (map (i: i.drv) (builtins.genericClosure {
      startSet = map (d: { key = d.name; drv = d; })
        (lib.filter isRos (buildInputs ++ nativeBuildInputs ++ propagatedBuildInputs));
      operator = { drv, ... }: map (d: { key = d.name; drv = d; }) (runDepends drv);
    }));
in

(if buildType == "ament_python" then python3Packages.buildPythonPackage
else stdenv.mkDerivation) (finalAttrs: (removeAttrs args [ "rosBuildExportDepends" "rosExecDepends" "splitDev" ]) // {
  inherit doCheck dontWrapQtApps separateDebugInfo;

  buildInputs = buildInputs ++ rosBuildClosure;

  # Disable warnings that cause "Log limit exceeded" errors on Hydra in lots of
  # packages that use Eigen
  CXXFLAGS = CXXFLAGS + "-Wno-deprecated-declarations -Wno-deprecated-copy";

} // lib.optionalAttrs splitDev {
  outputs = args.outputs or [ "out" "dev" ];
  preFixup = ''
    source ${./split-dev-output.sh}
    splitDevOutput
  '' + preFixup;
} // {
  passthru = passthru // {
    rosPackage = true;
    inherit rosDistro rosVersion rosBuildExportDepends rosExecDepends;
    # A workspace of this package and its runtime closure. Its setup-sh
    # attribute renders a script to source, for use without nix develop.
    ws = buildEnv { paths = [ finalAttrs.finalPackage ]; };
  };
} // lib.optionalAttrs (buildType == "ament_python") {
  dontUseCmakeConfigure = true;

  # Python programs are wrapped with a PYTHONPATH built from propagated inputs,
  # so Python packages still need their runtime ROS dependencies propagated.
  # Their out output specifically: propagating a split package would otherwise
  # pick its dev output, putting headers and CMake configs (and the -dev
  # outputs those name) in the runtime closure of every Python package.
  propagatedBuildInputs = propagatedBuildInputs
    ++ map (d: d.out or d) (lib.unique (rosBuildExportDepends ++ rosExecDepends));

  # Modeled after colcon.
  # As of 0.12.1, colcon uses the legacy distutils install.py script, so we do
  # the same. Using modern techniques, such as "pip install" with setuptools,
  # causes issues due to differences in setup.cfg interpretation. In particular,
  # it ignores the "install-scripts" directive, which is commonly used in ROS
  # to install binaries to "$out/lib/<package name>".
  # https://github.com/colcon/colcon-core/blob/0.12.1/colcon_core/task/python/build.py#L84
  format = "other";

  nativeBuildInputs = nativeBuildInputs ++ [ python3Packages.setuptools ];

  buildPhase = ''
    runHook preBuild

    python setup.py build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/${python3Packages.python.sitePackages}"
    export PYTHONPATH="$out/${python3Packages.python.sitePackages}:$PYTHONPATH"
    python setup.py install --prefix="$out" --single-version-externally-managed --record /dev/null

    runHook postInstall
  '';

  postFixup = ''
    ${postFixup}
    find "$out/lib" -mindepth 1 -maxdepth 1 -type d ! -name '${python3Packages.python.libPrefix}' -print0 | while read -d "" libpkgdir; do
      wrapPythonProgramsIn "$libpkgdir" "$out $pythonPath"
    done
  '';

  # Fix error: separateDebugInfo = true requires __structuredAttrs if {dis,}allowedRequisites or {dis,}allowedReferences is set
  __structuredAttrs = separateDebugInfo;
})
