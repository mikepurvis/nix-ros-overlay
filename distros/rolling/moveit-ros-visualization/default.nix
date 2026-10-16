
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, class-loader, eigen, geometric-shapes, interactive-markers, moveit-common, moveit-ros-planning-interface, moveit-ros-robot-interaction, moveit-ros-warehouse, object-recognition-msgs, pkg-config, pluginlib, qt6, rclcpp, rclpy, rviz2, tf2-eigen }:
buildRosPackage {
  pname = "ros-rolling-moveit-ros-visualization";
  version = "2.15.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/rolling/moveit_ros_visualization/2.15.2-1.tar.gz";
    name = "2.15.2-1.tar.gz";
    sha256 = "d55020db707be29dbf00673b14edda43a86f689e6c48259762ae9843bbbc810e";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake class-loader eigen geometric-shapes interactive-markers moveit-common moveit-ros-planning-interface moveit-ros-robot-interaction moveit-ros-warehouse object-recognition-msgs pkg-config pluginlib qt6.qtbase rclcpp rclpy rviz2 tf2-eigen ];
  nativeBuildInputs = [ ament-cmake pkg-config ];
  rosBuildExportDepends = [ geometric-shapes interactive-markers moveit-common moveit-ros-planning-interface moveit-ros-robot-interaction moveit-ros-warehouse object-recognition-msgs pluginlib rclcpp rclpy rviz2 tf2-eigen ];
  rosExecDepends = [ geometric-shapes interactive-markers moveit-common moveit-ros-planning-interface moveit-ros-robot-interaction moveit-ros-warehouse object-recognition-msgs pluginlib rclcpp rclpy rviz2 tf2-eigen ];

  meta = {
    description = "Components of MoveIt that offer visualization";
    license = with lib.licenses; [ bsd3 ];
  };
}
