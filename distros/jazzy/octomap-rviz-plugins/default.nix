
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-lint-auto, ament-lint-common, octomap, octomap-msgs, qt5, rclcpp, rviz-common, rviz-default-plugins, rviz-rendering }:
buildRosPackage {
  pname = "ros-jazzy-octomap-rviz-plugins";
  version = "2.1.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/octomap_rviz_plugins-release/archive/release/jazzy/octomap_rviz_plugins/2.1.0-1.tar.gz";
    name = "2.1.0-1.tar.gz";
    sha256 = "50086857dda7911e3dfe93b860c3ede0568277dadad38f2a01c4f24cfb12d9ca";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto octomap-msgs rclcpp rviz-common rviz-default-plugins rviz-rendering ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ octomap qt5.qtbase ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ octomap-msgs rclcpp rviz-common rviz-default-plugins rviz-rendering ];

  meta = {
    description = "A set of plugins for displaying occupancy information decoded from binary octomap messages.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
