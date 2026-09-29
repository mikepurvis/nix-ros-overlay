
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-index-cpp, moveit-configs-utils, moveit-resources-fanuc-moveit-config, moveit-resources-panda-moveit-config, moveit-setup-framework, pluginlib, rclcpp }:
buildRosPackage {
  pname = "ros-jazzy-moveit-setup-controllers";
  version = "2.12.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/jazzy/moveit_setup_controllers/2.12.4-1.tar.gz";
    name = "2.12.4-1.tar.gz";
    sha256 = "3f2ccfdeca53d0b334b617a451e05d34d5a57551ae06b496ca2cf1b7277e1396";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-index-cpp moveit-setup-framework pluginlib rclcpp ];
  checkInputs = [ ament-cmake-gtest moveit-configs-utils moveit-resources-fanuc-moveit-config moveit-resources-panda-moveit-config ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-index-cpp moveit-setup-framework pluginlib rclcpp ];
  rosExecDepends = [ ament-index-cpp moveit-setup-framework pluginlib rclcpp ];

  meta = {
    description = "MoveIt Setup Steps for ROS 2 Control";
    license = with lib.licenses; [ bsd3 ];
  };
}
