
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-pytest, roboplan, roboplan-cartesian-planning, roboplan-example-models, roboplan-oink, roboplan-rrt, roboplan-simple-ik, roboplan-toppra, xacro }:
buildRosPackage {
  pname = "ros-rolling-roboplan-examples";
  version = "0.6.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/roboplan-release/archive/release/rolling/roboplan_examples/0.6.1-1.tar.gz";
    name = "0.6.1-1.tar.gz";
    sha256 = "8323c2ded04d16a423d54b4fe32164f36305c3ab4d8d5cdf367d10bcabd36350";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake roboplan roboplan-cartesian-planning roboplan-example-models roboplan-oink roboplan-rrt roboplan-simple-ik roboplan-toppra ];
  checkInputs = [ ament-cmake-pytest ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ roboplan roboplan-cartesian-planning roboplan-example-models roboplan-oink roboplan-rrt roboplan-simple-ik roboplan-toppra ];
  rosExecDepends = [ roboplan roboplan-cartesian-planning roboplan-example-models roboplan-oink roboplan-rrt roboplan-simple-ik roboplan-toppra xacro ];

  meta = {
    description = "Basic examples of RoboPlan.";
    license = with lib.licenses; [ mit ];
  };
}
