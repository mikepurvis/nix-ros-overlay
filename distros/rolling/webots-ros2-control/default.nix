
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, controller-manager, hardware-interface, pluginlib, rclcpp, rclcpp-lifecycle, ros-environment, webots-ros2-driver }:
buildRosPackage {
  pname = "ros-rolling-webots-ros2-control";
  version = "2025.0.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/webots_ros2-release/archive/release/rolling/webots_ros2_control/2025.0.1-2.tar.gz";
    name = "2025.0.1-2.tar.gz";
    sha256 = "717453b382245f6189b687f2428f00f717bd8c8c4239e355d6f347edfa8e1605";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake controller-manager hardware-interface pluginlib rclcpp rclcpp-lifecycle ros-environment webots-ros2-driver ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ controller-manager hardware-interface pluginlib rclcpp rclcpp-lifecycle webots-ros2-driver ];
  rosExecDepends = [ controller-manager hardware-interface pluginlib rclcpp rclcpp-lifecycle webots-ros2-driver ];

  meta = {
    description = "ros2_control plugin for Webots";
    license = with lib.licenses; [ asl20 ];
  };
}
