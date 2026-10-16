# Unreleased upstream ROS changes the dev/out split relies on, as diffs
# fetched from upstream, and a function each distro's pending-upstream.nix
# uses to apply them. Each package is built from its own release tarball, so
# it takes only its directory's part of each diff. Patches only apply where
# the split is on; otherwise a distro builds what it released. Listed in
# PENDING-UPSTREAM.md.
self: rosSelf: rosSuper:
let
  inherit (self) lib;

  patchPackage = diffs: dir: { nativeBuildInputs ? [ ], postPatch ? "", ... }: {
    nativeBuildInputs = nativeBuildInputs ++ [ self.buildPackages.patchutils ];
    postPatch = ''
      for diff in ${lib.escapeShellArgs diffs}; do
        filterdiff -p1 -i '${dir}/*' "$diff" > slice.diff
        if [ -s slice.diff ]; then
          patch -p2 --no-backup-if-mismatch < slice.diff
        fi
        rm slice.diff
      done
    '' + postPatch;
  };

  name = dir: builtins.replaceStrings [ "_" ] [ "-" ] dir;
in
{
  diffs = {
    # ament/ament_cmake#631: make ament_export_libraries respect
    # CMAKE_INSTALL_LIBDIR. Released in rolling; #641 builds on it.
    ament_cmake_631 = self.fetchurl {
      url = "https://github.com/ament/ament_cmake/commit/eb6039077fc34e16e3e34edf8a8f49dc5e127c16.diff";
      hash = "sha256-ZLbynnKJRzF+rBsi5fwOXTnlus6ppMN/kz50QxGU19c=";
    };
    # ament/ament_cmake#641: AMENT_CMAKE_CONFIG_INSTALL_PREFIX, so CMake config
    # files can be installed into the dev output and name the install prefix
    # absolutely. Pinned to the PR's head commit so the hash stays put as it
    # moves.
    ament_cmake_641 = self.fetchurl {
      url = "https://github.com/ament/ament_cmake/compare/8d22f5797ab128744cfc25a1fce2cbffc7b4611f...92d2f36c25ba3f582a71aef0ccff24346d08e0b3.diff";
      hash = "sha256-3EJcluyksbUgxoGYRKrUdogVapAy0wgOyjEaHxPpDLM=";
    };
  };

  # The ament_cmake packages whose output #641 changes. It also has the
  # build-tool packages install their CMake modules into the config directory,
  # but buildRosPackage's fixup moves them there anyway.
  amentCmake641Dirs = [
    "ament_cmake_core"
    "ament_cmake_export_include_directories"
    "ament_cmake_export_libraries"
    "ament_cmake_export_targets"
  ];

  apply = { diffs, dirs }: builtins.listToAttrs (map (dir: {
    name = name dir;
    value = if rosSelf.splitDevOutputs
      then rosSuper.${name dir}.overrideAttrs (patchPackage diffs dir)
      else rosSuper.${name dir};
  }) (builtins.filter (dir: rosSuper ? ${name dir}) dirs));
}
