
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-python, ament-lint-auto, ament-lint-common, dynamixel-sdk, dynamixel-sdk-custom-interfaces, rclcpp, rclpy }:
buildRosPackage {
  pname = "ros-rolling-dynamixel-sdk-examples";
  version = "4.0.3-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/dynamixel_sdk-release/archive/release/rolling/dynamixel_sdk_examples/4.0.3-2.tar.gz";
    name = "4.0.3-2.tar.gz";
    sha256 = "e994696bec6ba96c355a96b8c57abbe92f604e76ead5aeddb2fa87b50ded8965";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-python dynamixel-sdk dynamixel-sdk-custom-interfaces rclcpp rclpy ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python ];
  rosBuildExportDepends = [ dynamixel-sdk dynamixel-sdk-custom-interfaces rclcpp rclpy ];
  rosExecDepends = [ dynamixel-sdk dynamixel-sdk-custom-interfaces rclcpp rclpy ];

  meta = {
    description = "ROS 2 examples using ROBOTIS DYNAMIXEL SDK";
    license = with lib.licenses; [ asl20 ];
  };
}
