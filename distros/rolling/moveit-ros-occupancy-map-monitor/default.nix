
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, eigen, eigen3-cmake-module, geometric-shapes, moveit-common, moveit-core, moveit-msgs, octomap, pluginlib, rclcpp, tf2-ros }:
buildRosPackage {
  pname = "ros-rolling-moveit-ros-occupancy-map-monitor";
  version = "2.15.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/rolling/moveit_ros_occupancy_map_monitor/2.15.2-1.tar.gz";
    name = "2.15.2-1.tar.gz";
    sha256 = "e5b9d5d228c13b8abd263aeb18d4c88fc4266e40fa7ebe277dab7ee07f14fd66";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake eigen3-cmake-module geometric-shapes moveit-common moveit-core moveit-msgs pluginlib rclcpp tf2-ros ];
  checkInputs = [ ament-cmake-gmock ];
  propagatedBuildInputs = [ eigen octomap ];
  nativeBuildInputs = [ ament-cmake eigen3-cmake-module ];
  rosBuildExportDepends = [ eigen3-cmake-module geometric-shapes moveit-common moveit-core moveit-msgs pluginlib rclcpp tf2-ros ];
  rosExecDepends = [ geometric-shapes moveit-common moveit-core moveit-msgs pluginlib rclcpp tf2-ros ];

  meta = {
    description = "Components of MoveIt connecting to occupancy map";
    license = with lib.licenses; [ bsd3 ];
  };
}
