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
    # absolutely. Pinned to its review-641 state on the fork (the version with
    # AMENT_INSTALL_CMAKEDIR and the defaulted ament_package_install_prefix,
    # which the rosidl change uses) until that is pushed to the PR.
    ament_cmake_641 = self.fetchurl {
      url = "https://github.com/mikepurvis/ament_cmake/compare/35465d2f104c29a9da879d3bbb4a74a362355abc...a533aee54d4b5bbb41220f041e28484ad1e111f5.diff";
      hash = "sha256-PLSfVnYNCeReiqzUDJg9rI55EWGZeYlRRvA3Ao6HAo4=";
    };
    # Prototype, not yet a PR: interface packages export <pkg>_DATADIR, which
    # rosidl_find_package_idl (ros2/rosidl#754) already prefers, and
    # rosidl_cmake and its generators find their lib and share directories
    # through ament_package_install_prefix instead of ${pkg_DIR}/.. walks.
    rosidl_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl/compare/4537874f320ef8b350c3df7f5b6b487b409fa22f...5838cd2fd1348bdd6a062b1f84b7ef93cddc4f9e.diff";
      hash = "sha256-uXuijR1/mVDGUaNGNo67zGiV/vpt+gYPbzvf0VRDdcA=";
    };
    # The same prototype for the generators and typesupports in other repos,
    # which also find dependency IDL through rosidl_find_package_idl.
    rosidl_typesupport_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_typesupport/compare/6ee2aff71b5f547d707450b94a911d06ec29347e...72e8ef518e831773a2ab78a2b8847707eafc1272.diff";
      hash = "sha256-SBRH+K8eruafU68QaS7xiWY5GgeKjU+/cg9L9it1oU8=";
    };
    rosidl_typesupport_fastrtps_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_typesupport_fastrtps/compare/55bc71056c17097e316fd75116e709656d032a5c...45e896e5a7ce87814204dc47d41209fa7c92cc1d.diff";
      hash = "sha256-Ukx5xb/gtz2we54H4Zbi+N4/AQTqQH0e2SZFbt99z9A=";
    };
    rosidl_python_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_python/compare/fb4cb9a9ee8c33c6fd8861f42ef28c3c8628a48d...47fc40e72cbe019271404540f3da7c662802c752.diff";
      hash = "sha256-2d/b+aQBvr77rtZy02iLZAemvPeuP3BVSn9wD+A9FiU=";
    };
  };

  # The share-dir prototype across the rosidl repos. Each package takes only
  # its own directory's part, so all of them can be applied to every package.

  # The ament_cmake packages whose output #641 changes. It also has the
  # build-tool packages install their CMake modules into the config directory,
  # but buildRosPackage's fixup moves them there anyway.
  amentCmake641Dirs = [
    "ament_cmake_core"
    "ament_cmake_export_include_directories"
    "ament_cmake_export_libraries"
    "ament_cmake_export_targets"
  ];

  # The packages the rosidl share-dir prototype changes, across ros2/rosidl,
  # rosidl_typesupport, rosidl_typesupport_fastrtps and rosidl_python. Each
  # package takes only its own directory's part of the diffs.
  rosidlShareDirDirs = [
    "rosidl_cmake"
    "rosidl_generator_c"
    "rosidl_generator_cpp"
    "rosidl_generator_type_description"
    "rosidl_typesupport_introspection_c"
    "rosidl_typesupport_introspection_cpp"
    "rosidl_typesupport_c"
    "rosidl_typesupport_cpp"
    "rosidl_typesupport_fastrtps_c"
    "rosidl_typesupport_fastrtps_cpp"
    "rosidl_generator_py"
  ];

  apply = { diffs, dirs }: builtins.listToAttrs (map (dir: {
    name = name dir;
    value = if rosSelf.splitDevOutputs
      then rosSuper.${name dir}.overrideAttrs (patchPackage diffs dir)
      else rosSuper.${name dir};
  }) (builtins.filter (dir: rosSuper ? ${name dir}) dirs));
}
