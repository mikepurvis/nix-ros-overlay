
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-clang-tidy, ament-cmake, ament-cmake-copyright, ament-cmake-ros, ament-lint-auto, ament-lint-common, boost, gtest, rcl, rcl-action, rclcpp, rclcpp-action, ros-environment }:
buildRosPackage {
  pname = "ros-jazzy-rtest";
  version = "0.2.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rtest-release/archive/release/jazzy/rtest/0.2.4-1.tar.gz";
    name = "0.2.4-1.tar.gz";
    sha256 = "d4a75e117d7457a4959cf7a6f7a8e8318cae696e928cbe0c1324b24698a74bc0";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake ament-cmake-ros boost gtest rcl rcl-action rclcpp rclcpp-action ros-environment ];
  checkInputs = [ ament-clang-tidy ament-cmake-copyright ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros ];
  rosBuildExportDepends = [ action-msgs rcl rcl-action rclcpp rclcpp-action ];

  meta = {
    description = "This framework enables writing reliable, fully repeatable tests for C++ ROS 2 implementations.";
    license = with lib.licenses; [ asl20 ];
  };
}
