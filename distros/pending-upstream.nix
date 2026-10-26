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
rec {
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
    # Merged into rolling on 2026-10-26 but not yet released: the generators
    # and typesupports find a dependency's IDL through rosidl_find_package_idl
    # (ros2/rosidl#754) instead of walking ${dep_DIR}/.. inline.
    rosidl_1013 = self.fetchurl {
      url = "https://github.com/ros2/rosidl/commit/ad8357247b28ba0a5d555fb08927d8f38d78b87a.diff";
      hash = "sha256-cclsZITM8EOPdg9Kmu6UbEBysaglycJd7+ZUJNIEV1U=";
    };
    rosidl_typesupport_176 = self.fetchurl {
      url = "https://github.com/ros2/rosidl_typesupport/commit/dbf8467c4a73e852f90b50923674f572d62569d0.diff";
      hash = "sha256-XgxnGh3a58SliOk0jHTLX2kVwDu8xNvdo1bWueQ+oPI=";
    };
    rosidl_typesupport_fastrtps_169 = self.fetchurl {
      url = "https://github.com/ros2/rosidl_typesupport_fastrtps/commit/b61546a790ff6497641677bcee0329bb429ef087.diff";
      hash = "sha256-SEPDWZ//g02UD4w070IxBvkB5hV6Ov/nGkeG43yAVXQ=";
    };
    rosidl_python_268 = self.fetchurl {
      url = "https://github.com/ros2/rosidl_python/commit/f99517a26d277002e16ff51b87918c7a4dc1e80f.diff";
      hash = "sha256-F380iVgPeHq+/YXCEEmfMqLg4bvjnzH0GKss42Nwvwk=";
    };
    rosidl_dds_66 = self.fetchurl {
      url = "https://github.com/ros2/rosidl_dds/commit/02c25ced30cc2e8986f35fec3d1f1e5926cddf7f.diff";
      hash = "sha256-t5ZdHKoysi/Ijxa7MxTWqM6hDPOOjnwGn1Rx8uWgLYs=";
    };
    # ros2/rosidl#1006, also merged and unreleased: a fix to
    # rosidl_cmake_export_typesupport_libraries that the share-dir change
    # below is written on top of.
    rosidl_1006 = self.fetchurl {
      url = "https://github.com/ros2/rosidl/commit/dae40aa358cf2b726abcb904079fc11b0548ffb3.diff";
      hash = "sha256-53wmqaD1dRYkEK/f4sjm3/go1Vz5fD7bNmiKxcsqZpk=";
    };
    # Prototype, not yet a PR: interface packages export <pkg>_DATADIR, which
    # rosidl_find_package_idl already prefers, and the generators and
    # typesupports find their own lib and share directories through
    # ament_package_install_prefix (#641) instead of ${pkg_DIR}/.. walks.
    rosidl_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl/compare/dae40aa358cf2b726abcb904079fc11b0548ffb3...2a0380d67443f69a79762165a20c278292f3e255.diff";
      hash = "sha256-KhlTPHd0bnaNpVfCfjhh/830OShf/kAi/NWj19ZiMTg=";
    };
    rosidl_typesupport_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_typesupport/compare/dbf8467c4a73e852f90b50923674f572d62569d0...8b16e27abf3e025d89bba45cb6a52a8339e381d0.diff";
      hash = "sha256-pxWTaQHt2blppXYgQlzfNReW9Pz3NqMWl0g0s0ZrMzQ=";
    };
    rosidl_typesupport_fastrtps_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_typesupport_fastrtps/compare/b61546a790ff6497641677bcee0329bb429ef087...48fa88de100cd46d5f75f5847752b5b1434b4e9e.diff";
      hash = "sha256-RQz9B8jQbuI9mYYoQ4y1f0O6dUNeZs+r23qTtNMZxF8=";
    };
    rosidl_python_share_dir = self.fetchurl {
      url = "https://github.com/mikepurvis/rosidl_python/compare/f99517a26d277002e16ff51b87918c7a4dc1e80f...ce5f8beaf9d9b37fe92690dabf24430686fd9c29.diff";
      hash = "sha256-DvAGEqMjRO14RhOHtlSOPLnLw+7lE9hiikNi71pwRbI=";
    };
    # The same for rosidl_dds and rosidl_rust, kept in-tree until they have
    # a fork to live on. rosidl_rust's also finds dependency IDL through
    # rosidl_find_package_idl, as #1013 and friends do for the others.
    rosidl_dds_share_dir = ./pending-upstream/rosidl_dds-share-dir.diff;
    rosidl_rust_share_dir = ./pending-upstream/rosidl_rust-share-dir.diff;
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

  # The rosidl changes in the order they apply: the merged ones, then the
  # prototype on top. Each package takes only its own directory's part, so
  # all of them can be applied to every package below.
  rosidlDiffs = with diffs; [
    rosidl_1013
    rosidl_1006
    rosidl_typesupport_176
    rosidl_typesupport_fastrtps_169
    rosidl_python_268
    rosidl_dds_66
    rosidl_share_dir
    rosidl_typesupport_share_dir
    rosidl_typesupport_fastrtps_share_dir
    rosidl_python_share_dir
    rosidl_dds_share_dir
    rosidl_rust_share_dir
  ];

  # The packages the rosidl changes touch, across ros2/rosidl,
  # rosidl_typesupport, rosidl_typesupport_fastrtps, rosidl_python,
  # rosidl_dds and rosidl_rust.
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
    "rosidl_generator_dds_idl"
    "rosidl_generator_rs"
  ];

  # Run dependencies the merged rosidl PRs add to package.xml, which the
  # released packages' generated dependency lists don't have yet: the
  # generators now call rosidl_find_package_idl from rosidl_cmake.
  rosidlAddedDeps = {
    rosidl_generator_type_description = [ "rosidl-cmake" ];
    rosidl_typesupport_c = [ "rosidl-cmake" ];
    rosidl_typesupport_cpp = [ "rosidl-cmake" ];
    rosidl_typesupport_fastrtps_c = [ "rosidl-cmake" ];
    rosidl_typesupport_fastrtps_cpp = [ "rosidl-cmake" ];
    rosidl_generator_dds_idl = [ "rosidl-cmake" ];
  };

  apply = { diffs, dirs, addedDeps ? { } }: builtins.listToAttrs (map (dir: {
    name = name dir;
    value = if rosSelf.splitDevOutputs
      then rosSuper.${name dir}.overrideAttrs (attrs:
        patchPackage diffs dir attrs // {
          propagatedBuildInputs = attrs.propagatedBuildInputs or [ ]
            ++ map (dep: rosSelf.${dep}) (addedDeps.${dir} or [ ]);
        })
      else rosSuper.${name dir};
  }) (builtins.filter (dir: rosSuper ? ${name dir}) dirs));
}
