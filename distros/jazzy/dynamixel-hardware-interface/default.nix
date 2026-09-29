
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, dynamixel-interfaces, dynamixel-sdk, hardware-interface, pluginlib, rclcpp, realtime-tools, std-srvs }:
buildRosPackage {
  pname = "ros-jazzy-dynamixel-hardware-interface";
  version = "1.5.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/dynamixel_hardware_interface-release/archive/release/jazzy/dynamixel_hardware_interface/1.5.2-1.tar.gz";
    name = "1.5.2-1.tar.gz";
    sha256 = "cd0fd183068acb1f9fc5a296a1de7a87b30bb98b64508449a30ffbc112cff664";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake dynamixel-interfaces dynamixel-sdk hardware-interface pluginlib rclcpp realtime-tools std-srvs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ dynamixel-interfaces dynamixel-sdk hardware-interface pluginlib rclcpp realtime-tools std-srvs ];

  meta = {
    description = "ROS 2 package providing a hardware interface for controlling Dynamixel motors via the ROS 2 control framework.";
    license = with lib.licenses; [ asl20 ];
  };
}
