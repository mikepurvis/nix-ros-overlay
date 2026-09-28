
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-index-cpp, controller-manager, moveit-common, moveit-configs-utils, moveit-core, moveit-msgs, moveit-planners-ompl, moveit-resources-panda-moveit-config, moveit-ros-planning, moveit-ros-planning-interface, moveit-simple-controller-manager, pluginlib, position-controllers, rclcpp, rclcpp-action, rclcpp-components, robot-state-publisher, ros-testing, rviz2, std-msgs, std-srvs, tf2-ros, trajectory-msgs }:
buildRosPackage {
  pname = "ros-jazzy-moveit-hybrid-planning";
  version = "2.12.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/jazzy/moveit_hybrid_planning/2.12.4-1.tar.gz";
    name = "2.12.4-1.tar.gz";
    sha256 = "7c80bebef8437deaab6f4b13ff5713b039450e76ad013d9bc4cd6dae628ca423";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  checkInputs = [ ament-cmake-gtest controller-manager moveit-configs-utils moveit-planners-ompl moveit-resources-panda-moveit-config moveit-simple-controller-manager position-controllers robot-state-publisher ros-testing ];
  propagatedBuildInputs = [ ament-index-cpp moveit-common moveit-core moveit-msgs moveit-ros-planning moveit-ros-planning-interface pluginlib rclcpp rclcpp-action rclcpp-components std-msgs std-srvs tf2-ros trajectory-msgs ];
  nativeBuildInputs = [ ament-cmake ];
  rosExecDepends = [ controller-manager moveit-resources-panda-moveit-config position-controllers robot-state-publisher rviz2 ];

  meta = {
    description = "Hybrid planning components of MoveIt 2";
    license = with lib.licenses; [ bsd3 ];
  };
}
