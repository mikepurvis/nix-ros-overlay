
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-cmake-gtest, ament-lint-auto, ament-lint-common, can-msgs, lifecycle-msgs, rclcpp, rclcpp-components, rclcpp-lifecycle, ros2-socketcan-msgs }:
buildRosPackage {
  pname = "ros-jazzy-ros2-socketcan";
  version = "1.4.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ros2_socketcan-release/archive/release/jazzy/ros2_socketcan/1.4.0-1.tar.gz";
    name = "1.4.0-1.tar.gz";
    sha256 = "e4127ef2b6f68820f8395678e083efa11d70bdaa9d08a54c0c21c1f08201f1e3";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto can-msgs lifecycle-msgs rclcpp rclcpp-components rclcpp-lifecycle ros2-socketcan-msgs ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ can-msgs lifecycle-msgs rclcpp rclcpp-components rclcpp-lifecycle ros2-socketcan-msgs ];

  meta = {
    description = "Simple wrapper around SocketCAN";
    license = with lib.licenses; [ asl20 ];
  };
}
