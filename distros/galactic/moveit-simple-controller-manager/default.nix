
# Copyright 2021 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, control-msgs, moveit-common, moveit-core, pluginlib, rclcpp, rclcpp-action }:
buildRosPackage {
  pname = "ros-galactic-moveit-simple-controller-manager";
  version = "2.2.1-r1";

  src = fetchurl {
    url = "https://github.com/moveit/moveit2-release/archive/release/galactic/moveit_simple_controller_manager/2.2.1-1.tar.gz";
    name = "2.2.1-1.tar.gz";
    sha256 = "e53081d26a7d9c5e76d6501f4e58c63ac519d0bee51e3aabc6873ac2bc54b922";
  };

  buildType = "ament_cmake";
  buildInputs = [ moveit-common ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ control-msgs moveit-core pluginlib rclcpp rclcpp-action ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''A generic, simple controller manager plugin for MoveIt.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
