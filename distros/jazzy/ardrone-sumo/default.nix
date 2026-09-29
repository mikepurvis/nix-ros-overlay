
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ardrone-sdk, cv-bridge, opencv, rclcpp, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-ardrone-sumo";
  version = "2.0.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ardrone_ros-release/archive/release/jazzy/ardrone_sumo/2.0.3-1.tar.gz";
    name = "2.0.3-1.tar.gz";
    sha256 = "608ad73a37b04ee408364d5b74a383ea8067ec8f8b6725fcbe243dc39689a1c6";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ardrone-sdk cv-bridge rclcpp sensor-msgs ];
  propagatedBuildInputs = [ opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ardrone-sdk cv-bridge rclcpp sensor-msgs ];
  rosExecDepends = [ ardrone-sdk cv-bridge rclcpp sensor-msgs ];

  meta = {
    description = "Control the Parrot JumpingSumo drone via ROS2 topics";
    license = with lib.licenses; [ asl20 ];
  };
}
