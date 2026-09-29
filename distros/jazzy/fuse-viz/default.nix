
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-ros, ament-lint-auto, ament-lint-common, eigen, fuse-constraints, fuse-core, fuse-msgs, fuse-variables, geometry-msgs, qt5, rviz-common, rviz-rendering, tf2-geometry-msgs }:
buildRosPackage {
  pname = "ros-jazzy-fuse-viz";
  version = "1.1.6-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/fuse-release/archive/release/jazzy/fuse_viz/1.1.6-1.tar.gz";
    name = "1.1.6-1.tar.gz";
    sha256 = "314aad8aa8a5eac2a584450f773e3943890609cd70b2bc6887e9d718c597b6f1";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros fuse-constraints fuse-core fuse-msgs fuse-variables geometry-msgs qt5.qtbase rviz-common rviz-rendering tf2-geometry-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ eigen ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ fuse-constraints fuse-core fuse-msgs fuse-variables geometry-msgs rviz-common rviz-rendering tf2-geometry-msgs ];

  meta = {
    description = "The fuse_viz package provides visualization tools for fuse.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
