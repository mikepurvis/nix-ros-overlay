
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-index-python, ament-pep257, demo-nodes-py, launch-ros, nodl, python3Packages, ros2launch, sros2 }:
buildRosPackage {
  pname = "ros-jazzy-ros2launch-security";
  version = "1.0.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ros2launch_security-release/archive/release/jazzy/ros2launch_security/1.0.2-1.tar.gz";
    name = "1.0.2-1.tar.gz";
    sha256 = "719ab9708c6175df557f634a71739e4232f363ed7fec0824c7e5a7b581f90e4b";
  };

  buildType = "ament_python";
  buildInputs = [ ament-index-python nodl ros2launch sros2 ];
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 demo-nodes-py launch-ros python3Packages.pytest ];
  rosBuildExportDepends = [ ament-index-python nodl ros2launch sros2 ];

  meta = {
    description = "Security extensions for ros2 launch";
    license = with lib.licenses; [ asl20 ];
  };
}
