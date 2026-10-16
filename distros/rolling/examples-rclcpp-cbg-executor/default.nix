
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, rclcpp, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-examples-rclcpp-cbg-executor";
  version = "0.22.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/examples-release/archive/release/rolling/examples_rclcpp_cbg_executor/0.22.0-1.tar.gz";
    name = "0.22.0-1.tar.gz";
    sha256 = "beb690d0bc3195dc50f4413ce02c3e641c55682ca16d2a4c9461e6792732806f";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rclcpp std-msgs ];
  rosExecDepends = [ rclcpp std-msgs ];

  meta = {
    description = "Example for multiple Executor instances in one process, using the callback-group-level interface of the Executor class.";
    license = with lib.licenses; [ asl20 ];
  };
}
