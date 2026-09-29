
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, rclcpp, rclcpp-action, rcutils, ros-gz-interfaces, sensor-msgs, std-msgs, turtlebot4-msgs }:
buildRosPackage {
  pname = "ros-jazzy-turtlebot4-gz-toolbox";
  version = "2.0.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/turtlebot4_simulator-release/archive/release/jazzy/turtlebot4_gz_toolbox/2.0.2-1.tar.gz";
    name = "2.0.2-1.tar.gz";
    sha256 = "0b10f7f44e5af0a131ecf1b7755ff900cde1e524ac2f4b91e75bd6aaab85c7ed";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp rclcpp-action rcutils ros-gz-interfaces sensor-msgs std-msgs turtlebot4-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rclcpp rclcpp-action rcutils ros-gz-interfaces sensor-msgs std-msgs turtlebot4-msgs ];
  rosExecDepends = [ rclcpp rclcpp-action rcutils ros-gz-interfaces sensor-msgs std-msgs turtlebot4-msgs ];

  meta = {
    description = "Turtlebot4 Gazebo Toolbox";
    license = with lib.licenses; [ asl20 ];
  };
}
