
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, example-interfaces, rclcpp }:
buildRosPackage {
  pname = "ros-rolling-examples-rclcpp-async-client";
  version = "0.22.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/examples-release/archive/release/rolling/examples_rclcpp_async_client/0.22.0-1.tar.gz";
    name = "0.22.0-1.tar.gz";
    sha256 = "3c46e608b840f437d0f02a96014e8a009d205e7eb21c83149b6ccd0a240b6942";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake example-interfaces rclcpp ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ example-interfaces rclcpp ];
  rosExecDepends = [ example-interfaces rclcpp ];

  meta = {
    description = "Example of an async service client";
    license = with lib.licenses; [ asl20 ];
  };
}
