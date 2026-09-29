
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, controller-manager, hardware-interface, pluginlib, rclcpp, rclcpp-lifecycle, ros-environment, webots-ros2-driver }:
buildRosPackage {
  pname = "ros-jazzy-webots-ros2-control";
  version = "2025.0.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/webots_ros2-release/archive/release/jazzy/webots_ros2_control/2025.0.0-1.tar.gz";
    name = "2025.0.0-1.tar.gz";
    sha256 = "7bf2f9dad0c1fd34ae443f2c3f3fec390a50d8d6b250373e0bece08f46bdf90c";
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
