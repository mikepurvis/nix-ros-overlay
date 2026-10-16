
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, binutils, boost, fmt, plotjuggler, plotjuggler-msgs, qt5, rclcpp, rcpputils, rosbag2-transport, tf2-msgs, tf2-ros }:
buildRosPackage {
  pname = "ros-rolling-plotjuggler-ros";
  version = "2.3.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/plotjuggler-ros-plugins-release/archive/release/rolling/plotjuggler_ros/2.3.1-2.tar.gz";
    name = "2.3.1-2.tar.gz";
    sha256 = "d7f92c3147e5b12e576a29c60fb50b4c0aa3c2695c34edbb8eb7c085216dacc8";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake plotjuggler plotjuggler-msgs rclcpp rcpputils rosbag2-transport tf2-msgs tf2-ros ];
  propagatedBuildInputs = [ binutils boost fmt qt5.qtbase qt5.qtsvg qt5.qtwebsockets ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ plotjuggler plotjuggler-msgs rclcpp rcpputils rosbag2-transport tf2-msgs tf2-ros ];
  rosExecDepends = [ plotjuggler plotjuggler-msgs rclcpp rcpputils rosbag2-transport tf2-msgs tf2-ros ];

  meta = {
    description = "PlotJuggler plugin for ROS";
    license = with lib.licenses; [ agpl3Only ];
  };
}
