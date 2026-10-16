
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-clang-format, ament-lint-auto, ament-lint-common, apriltag-msgs, cv-bridge, image-transport, pluginlib, rclcpp, rclcpp-components, ros-environment, sensor-msgs }:
buildRosPackage {
  pname = "ros-rolling-apriltag-detector";
  version = "3.0.4-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/apriltag_detector-release/archive/release/rolling/apriltag_detector/3.0.4-2.tar.gz";
    name = "3.0.4-2.tar.gz";
    sha256 = "d7c65f8bc0f715e7299ece65b2698fac25d784f1a849479b2a5b8cee37040e49";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake apriltag-msgs cv-bridge image-transport pluginlib rclcpp rclcpp-components ros-environment sensor-msgs ];
  checkInputs = [ ament-cmake-clang-format ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ros-environment ];
  rosBuildExportDepends = [ apriltag-msgs cv-bridge image-transport pluginlib rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ apriltag-msgs cv-bridge image-transport pluginlib rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "ROS2 package for apriltag detection";
    license = with lib.licenses; [ asl20 ];
  };
}
