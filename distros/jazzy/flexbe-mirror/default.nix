
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, flexbe-core, flexbe-msgs, python3Packages, rclpy }:
buildRosPackage {
  pname = "ros-jazzy-flexbe-mirror";
  version = "3.0.7-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/flexbe_behavior_engine-release/archive/release/jazzy/flexbe_mirror/3.0.7-1.tar.gz";
    name = "3.0.7-1.tar.gz";
    sha256 = "056bc83ee2919329987a9ffc8102ee038f0f0e533e1fd61b64484354ce569297";
  };

  buildType = "ament_python";
  buildInputs = [ flexbe-core flexbe-msgs rclpy ];
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 python3Packages.pytest ];
  rosBuildExportDepends = [ flexbe-core flexbe-msgs rclpy ];
  rosExecDepends = [ flexbe-core flexbe-msgs rclpy ];

  meta = {
    description = "flexbe_mirror implements functionality to remotely mirror an executed behavior.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
