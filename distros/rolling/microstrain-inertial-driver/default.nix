
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-cmake-target-dependencies, ament-cpplint, diagnostic-aggregator, diagnostic-updater, eigen, geographiclib, geometry-msgs, git, lifecycle-msgs, microstrain-inertial-msgs, nav-msgs, nmea-msgs, rclcpp-lifecycle, ros-environment, rosidl-default-generators, rosidl-default-runtime, rtcm-msgs, sensor-msgs, std-msgs, std-srvs, tf2, tf2-geometry-msgs, tf2-ros }:
buildRosPackage {
  pname = "ros-rolling-microstrain-inertial-driver";
  version = "4.9.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/microstrain_inertial-release/archive/release/rolling/microstrain_inertial_driver/4.9.0-1.tar.gz";
    name = "4.9.0-1.tar.gz";
    sha256 = "6c26af4be760ae597a0128c612699170378ba9d855751f21bd3337c2333ad7e3";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-target-dependencies diagnostic-updater eigen geographiclib geometry-msgs git lifecycle-msgs microstrain-inertial-msgs nav-msgs nmea-msgs rclcpp-lifecycle ros-environment rosidl-default-generators rtcm-msgs sensor-msgs std-msgs std-srvs tf2 tf2-geometry-msgs tf2-ros ];
  checkInputs = [ ament-cmake-gtest ament-cpplint ];
  nativeBuildInputs = [ git rosidl-default-generators ];
  rosBuildExportDepends = [ diagnostic-updater geometry-msgs lifecycle-msgs microstrain-inertial-msgs nav-msgs nmea-msgs rclcpp-lifecycle rtcm-msgs sensor-msgs std-msgs std-srvs tf2 tf2-geometry-msgs tf2-ros ];
  rosExecDepends = [ diagnostic-aggregator diagnostic-updater geometry-msgs lifecycle-msgs microstrain-inertial-msgs nav-msgs nmea-msgs rclcpp-lifecycle rosidl-default-runtime rtcm-msgs sensor-msgs std-msgs std-srvs tf2 tf2-geometry-msgs tf2-ros ];

  meta = {
    description = "The ros_mscl package provides a driver for the LORD/Microstrain inertial products.";
    license = with lib.licenses; [ mit ];
  };
}
