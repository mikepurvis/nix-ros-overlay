
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, inverse-dynamics-solver, pluginlib, rclcpp, ros-testing, rosbag2-cpp, rosbag2-storage, rosbag2-storage-default-plugins, trajectory-msgs, ur-description }:
buildRosPackage {
  pname = "ros-jazzy-ur10-inverse-dynamics-solver";
  version = "2.0.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/inverse_dynamics_solver-release/archive/release/jazzy/ur10_inverse_dynamics_solver/2.0.3-1.tar.gz";
    name = "2.0.3-1.tar.gz";
    sha256 = "c402cc26cafd4c38de941422aa783ba2ef206f0482c28ad8b04e0d63fe1dffe8";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake inverse-dynamics-solver pluginlib ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common rclcpp ros-testing rosbag2-cpp rosbag2-storage rosbag2-storage-default-plugins trajectory-msgs ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ inverse-dynamics-solver pluginlib ];
  rosExecDepends = [ inverse-dynamics-solver pluginlib ur-description ];

  meta = {
    description = "A C++ library implementing the inverse dynamics solver for the UR10 real robot.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
