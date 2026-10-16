
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, flexbe-core, flexbe-msgs, python3Packages, rclpy }:
buildRosPackage {
  pname = "ros-rolling-flexbe-input";
  version = "4.1.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/flexbe_behavior_engine-release/archive/release/rolling/flexbe_input/4.1.4-1.tar.gz";
    name = "4.1.4-1.tar.gz";
    sha256 = "ea2c52eae5c778e6feeb16e95d07f11ebbce8d3c602960bf0636aa0579724f67";
  };

  buildType = "ament_python";
  buildInputs = [ flexbe-core flexbe-msgs rclpy ];
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 python3Packages.pytest ];
  rosBuildExportDepends = [ flexbe-core flexbe-msgs rclpy ];
  rosExecDepends = [ flexbe-core flexbe-msgs rclpy ];

  meta = {
    description = "flexbe_input enables to send data to onboard behavior when required.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
