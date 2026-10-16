
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, image-geometry, opencv, rclcpp, rclcpp-components, sensor-msgs }:
buildRosPackage {
  pname = "ros-rolling-depthimage-to-laserscan";
  version = "2.5.1-r3";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/depthimage_to_laserscan-release/archive/release/rolling/depthimage_to_laserscan/2.5.1-3.tar.gz";
    name = "2.5.1-3.tar.gz";
    sha256 = "b2b79f1a24b1814b2f73469a1fc7f37a9a33eac1d6b41facc7a74b9b3cc390c9";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros image-geometry rclcpp rclcpp-components sensor-msgs ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ image-geometry rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ image-geometry rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "depthimage_to_laserscan";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
