
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-clang-tidy, ament-cmake, ament-cmake-copyright, ament-cmake-ros, ament-lint-auto, ament-lint-common, boost, gtest, rcl, rcl-action, rclcpp, rclcpp-action, ros-environment }:
buildRosPackage {
  pname = "ros-rolling-rtest";
  version = "0.2.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rtest-release/archive/release/rolling/rtest/0.2.4-1.tar.gz";
    name = "0.2.4-1.tar.gz";
    sha256 = "96ef3d552e0dfa24bd8a9d9c671000aba0d8b6a239b58a5e5b76cce4c690329b";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake ament-cmake-ros boost gtest rcl rcl-action rclcpp rclcpp-action ros-environment ];
  checkInputs = [ ament-clang-tidy ament-cmake-copyright ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros ];
  rosBuildExportDepends = [ action-msgs rcl rcl-action rclcpp rclcpp-action ];
  rosExecDepends = [ action-msgs rcl rcl-action rclcpp rclcpp-action ];

  meta = {
    description = "This framework enables writing reliable, fully repeatable tests for C++ ROS 2 implementations.";
    license = with lib.licenses; [ asl20 ];
  };
}
