
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-xmllint, ament-lint-auto, diagnostic-updater, mrpt-libhwdrivers, mrpt-libros-bridge, mrpt-msgs, rclcpp-components, ros-environment, tf2-geometry-msgs, tf2-ros }:
buildRosPackage {
  pname = "ros-rolling-mrpt-sensorlib";
  version = "0.3.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mrpt_sensors-release/archive/release/rolling/mrpt_sensorlib/0.3.0-1.tar.gz";
    name = "0.3.0-1.tar.gz";
    sha256 = "0b1bbc425913e2c05724dcce56d1c8d3c0ce8bd649b8e683816c7859959417eb";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake diagnostic-updater mrpt-libhwdrivers mrpt-libros-bridge mrpt-msgs rclcpp-components ros-environment tf2-geometry-msgs tf2-ros ];
  checkInputs = [ ament-cmake-xmllint ament-lint-auto ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ diagnostic-updater mrpt-libhwdrivers mrpt-libros-bridge mrpt-msgs rclcpp-components tf2-geometry-msgs tf2-ros ];
  rosExecDepends = [ diagnostic-updater mrpt-libhwdrivers mrpt-libros-bridge mrpt-msgs rclcpp-components tf2-geometry-msgs tf2-ros ];

  meta = {
    description = "C++ library for the base generic MRPT sensor node";
    license = with lib.licenses; [ bsd3 ];
  };
}
