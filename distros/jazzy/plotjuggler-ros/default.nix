
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, binutils, boost, fmt, plotjuggler, plotjuggler-msgs, qt5, rclcpp, rcpputils, rosbag2-transport, tf2-msgs, tf2-ros }:
buildRosPackage {
  pname = "ros-jazzy-plotjuggler-ros";
  version = "2.3.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/plotjuggler-ros-plugins-release/archive/release/jazzy/plotjuggler_ros/2.3.1-1.tar.gz";
    name = "2.3.1-1.tar.gz";
    sha256 = "6e123fde962b6dc506b1d0784a9edbb55b45affece4a5f814aee54217c9d0a30";
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
