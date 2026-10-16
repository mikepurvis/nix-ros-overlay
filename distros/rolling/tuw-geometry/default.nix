
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-cppcheck, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, gtest-vendor, opencv, rclcpp, rclcpp-components, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-tuw-geometry";
  version = "0.1.4-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/tuw_geometry-release/archive/release/rolling/tuw_geometry/0.1.4-2.tar.gz";
    name = "0.1.4-2.tar.gz";
    sha256 = "699ebe2434aaa4fa485a6e53d9b94144b882f9b2fd767acd2bbe6c0d928292bb";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-ros gtest-vendor rclcpp rclcpp-components sensor-msgs std-msgs ];
  checkInputs = [ ament-cmake-cppcheck ament-cmake-gtest ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-cmake-ros gtest-vendor rclcpp rclcpp-components sensor-msgs std-msgs ];
  rosExecDepends = [ ament-cmake-ros gtest-vendor rclcpp rclcpp-components sensor-msgs std-msgs ];

  meta = {
    description = "The tuw_geometry package";
    license = with lib.licenses; [ bsd3 ];
  };
}
