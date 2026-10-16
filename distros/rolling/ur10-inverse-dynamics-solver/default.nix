
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, inverse-dynamics-solver, pluginlib, rclcpp, ros-testing, rosbag2-cpp, rosbag2-storage, rosbag2-storage-default-plugins, trajectory-msgs, ur-description }:
buildRosPackage {
  pname = "ros-rolling-ur10-inverse-dynamics-solver";
  version = "6.0.1-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/inverse_dynamics_solver-release/archive/release/rolling/ur10_inverse_dynamics_solver/6.0.1-4.tar.gz";
    name = "6.0.1-4.tar.gz";
    sha256 = "f739601ea09ad2c1978917b621bc055fd7170ad6df80d52b21736f7dccbe8a24";
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
