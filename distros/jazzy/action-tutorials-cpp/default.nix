
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-tutorials-interfaces, ament-cmake, ament-lint-auto, ament-lint-common, rclcpp, rclcpp-action, rclcpp-components }:
buildRosPackage {
  pname = "ros-jazzy-action-tutorials-cpp";
  version = "0.33.11-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/demos-release/archive/release/jazzy/action_tutorials_cpp/0.33.11-1.tar.gz";
    name = "0.33.11-1.tar.gz";
    sha256 = "5b1e0427a18664fc7a8bc5f011bbbfc35130e9096121b26a0b82521086a8d988";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-tutorials-interfaces ament-cmake rclcpp rclcpp-action rclcpp-components ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ action-tutorials-interfaces rclcpp rclcpp-action rclcpp-components ];
  rosExecDepends = [ action-tutorials-interfaces rclcpp rclcpp-action rclcpp-components ];

  meta = {
    description = "C++ action tutorial cpp code";
    license = with lib.licenses; [ asl20 ];
  };
}
