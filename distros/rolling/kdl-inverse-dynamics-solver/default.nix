
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, inverse-dynamics-solver, kdl-parser, orocos-kdl, pluginlib, rclcpp, ros-testing, ur-description }:
buildRosPackage {
  pname = "ros-rolling-kdl-inverse-dynamics-solver";
  version = "6.0.1-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/inverse_dynamics_solver-release/archive/release/rolling/kdl_inverse_dynamics_solver/6.0.1-4.tar.gz";
    name = "6.0.1-4.tar.gz";
    sha256 = "4e43778df1c051105fe44b1233e50bc91d7272990ce93a5b4324bac89d4954d4";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake inverse-dynamics-solver kdl-parser pluginlib rclcpp ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ros-testing ];
  propagatedBuildInputs = [ orocos-kdl ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ inverse-dynamics-solver kdl-parser pluginlib rclcpp ];
  rosExecDepends = [ inverse-dynamics-solver kdl-parser pluginlib rclcpp ur-description ];

  meta = {
    description = "A KDL-based library implementing an inverse dynamics solver for simulated robots.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
