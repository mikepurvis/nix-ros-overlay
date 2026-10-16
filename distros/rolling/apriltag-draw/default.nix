
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-clang-format, ament-lint-auto, ament-lint-common, apriltag-msgs, cv-bridge, image-transport, rclcpp, rclcpp-components, ros-environment, sensor-msgs }:
buildRosPackage {
  pname = "ros-rolling-apriltag-draw";
  version = "3.0.4-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/apriltag_detector-release/archive/release/rolling/apriltag_draw/3.0.4-2.tar.gz";
    name = "3.0.4-2.tar.gz";
    sha256 = "a70aa227e703a0b22a99acf7f7c3d2822ccb7198bb32f975ce037ea051d76df3";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake apriltag-msgs cv-bridge image-transport rclcpp rclcpp-components ros-environment sensor-msgs ];
  checkInputs = [ ament-cmake-clang-format ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ros-environment ];
  rosBuildExportDepends = [ apriltag-msgs cv-bridge image-transport rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ apriltag-msgs cv-bridge image-transport rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "ROS package for drawing apriltags on image";
    license = with lib.licenses; [ asl20 ];
  };
}
