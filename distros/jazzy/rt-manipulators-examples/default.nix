
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, rclcpp, rt-manipulators-cpp }:
buildRosPackage {
  pname = "ros-jazzy-rt-manipulators-examples";
  version = "1.1.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rt_manipulators_cpp-release/archive/release/jazzy/rt_manipulators_examples/1.1.0-1.tar.gz";
    name = "1.1.0-1.tar.gz";
    sha256 = "94c632520b05793a53334b0f391e14cce949564d5ea51bca7d2c39a6cb077a0f";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp rt-manipulators-cpp ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rclcpp rt-manipulators-cpp ];

  meta = {
    description = "Examples for RT Manipulators C++ Library";
    license = with lib.licenses; [ asl20 ];
  };
}
