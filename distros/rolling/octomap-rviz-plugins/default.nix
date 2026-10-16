
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-lint-auto, ament-lint-common, octomap, octomap-msgs, qt6, rclcpp, rviz-common, rviz-default-plugins, rviz-rendering }:
buildRosPackage {
  pname = "ros-rolling-octomap-rviz-plugins";
  version = "2.2.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/octomap_rviz_plugins-release/archive/release/rolling/octomap_rviz_plugins/2.2.0-2.tar.gz";
    name = "2.2.0-2.tar.gz";
    sha256 = "99b3f1cb53e5b837a93ebcb9d44ca662f305e48b29d1f33122ed51349ef891d2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto octomap-msgs rclcpp rviz-common rviz-default-plugins rviz-rendering ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ octomap qt6.qtbase ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ octomap-msgs rclcpp rviz-common rviz-default-plugins rviz-rendering ];
  rosExecDepends = [ octomap-msgs rclcpp rviz-common rviz-default-plugins rviz-rendering ];

  meta = {
    description = "A set of plugins for displaying occupancy information decoded from binary octomap messages.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
