
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, backward-ros, eigen, eigen3-cmake-module, kdl-parser, kinematics-interface, pluginlib, ros2-control-cmake, tf2-eigen-kdl }:
buildRosPackage {
  pname = "ros-jazzy-kinematics-interface-kdl";
  version = "1.7.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/kinematics_interface-release/archive/release/jazzy/kinematics_interface_kdl/1.7.1-1.tar.gz";
    name = "1.7.1-1.tar.gz";
    sha256 = "659705e85f816b84b4eda8f66c7c26e783ed9a53804a147fee0f45ce0a62790c";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake backward-ros eigen3-cmake-module kdl-parser kinematics-interface pluginlib ros2-control-cmake tf2-eigen-kdl ];
  checkInputs = [ ament-cmake-gmock ];
  propagatedBuildInputs = [ eigen ];
  nativeBuildInputs = [ ament-cmake eigen3-cmake-module ];
  rosBuildExportDepends = [ backward-ros kdl-parser kinematics-interface pluginlib tf2-eigen-kdl ];

  meta = {
    description = "KDL implementation of ros2_control kinematics interface";
    license = with lib.licenses; [ asl20 ];
  };
}
