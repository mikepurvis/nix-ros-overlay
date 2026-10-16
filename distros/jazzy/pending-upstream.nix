# Upstream ROS changes this overlay relies on that haven't been released for
# jazzy yet, applied as patches to the packages they change. Listed in
# PENDING-UPSTREAM.md.
#
# ament/ament_cmake#641: AMENT_CMAKE_CONFIG_INSTALL_PREFIX lets CMake config
# files be installed into the dev output, with generated files naming the
# install prefix absolutely. #641 targets rolling and builds on #631, which
# jazzy lacks, so both are applied. Each package is built from its own release
# tarball, so each takes only its directory's part of the diffs.
self: rosSelf: rosSuper:
let
  inherit (self) lib;

  diffs = [
    # Make ament_export_libraries respect CMAKE_INSTALL_LIBDIR
    (self.fetchurl {
      url = "https://github.com/ament/ament_cmake/commit/eb6039077fc34e16e3e34edf8a8f49dc5e127c16.diff";
      hash = "sha256-ZLbynnKJRzF+rBsi5fwOXTnlus6ppMN/kz50QxGU19c=";
    })
    # The PR, pinned to its head commit so the hash stays put as it moves.
    (self.fetchurl {
      url = "https://github.com/ament/ament_cmake/compare/8d22f5797ab128744cfc25a1fce2cbffc7b4611f...92d2f36c25ba3f582a71aef0ccff24346d08e0b3.diff";
      hash = "sha256-3EJcluyksbUgxoGYRKrUdogVapAy0wgOyjEaHxPpDLM=";
    })
  ];

  # Only the packages whose output the new variable changes. #641 also has
  # ament_cmake's build-tool packages install their CMake modules into the
  # config directory, but buildRosPackage's fixup moves them there anyway.
  dirs = [
    "ament_cmake_core"
    "ament_cmake_export_include_directories"
    "ament_cmake_export_libraries"
    "ament_cmake_export_targets"
  ];

  patchPackage = dir: { nativeBuildInputs ? [ ], postPatch ? "", ... }: {
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
builtins.listToAttrs (map (dir: {
  name = name dir;
  # Only needed for the dev/out split; otherwise build what jazzy released.
  value = if rosSelf.splitDevOutputs
    then rosSuper.${name dir}.overrideAttrs (patchPackage dir)
    else rosSuper.${name dir};
}) (builtins.filter (dir: rosSuper ? ${name dir}) dirs))
