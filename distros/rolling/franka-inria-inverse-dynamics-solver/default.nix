
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, eigen, inverse-dynamics-solver, pluginlib }:
buildRosPackage {
  pname = "ros-rolling-franka-inria-inverse-dynamics-solver";
  version = "6.0.1-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/inverse_dynamics_solver-release/archive/release/rolling/franka_inria_inverse_dynamics_solver/6.0.1-4.tar.gz";
    name = "6.0.1-4.tar.gz";
    sha256 = "e78a7cabe50e15154d3650ee78f01684dcb5702e2d234715f87b8145c8537412";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake inverse-dynamics-solver pluginlib ];
  propagatedBuildInputs = [ eigen ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ inverse-dynamics-solver pluginlib ];
  rosExecDepends = [ inverse-dynamics-solver pluginlib ];

  meta = {
    description = "A C++ library implementing the inverse dynamics solver for the Franka Emika Panda (FER) real robot.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
