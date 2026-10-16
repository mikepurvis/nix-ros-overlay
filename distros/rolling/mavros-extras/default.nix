
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-cmake-gtest, ament-cmake-pytest, ament-cmake-python, ament-lint-auto, ament-lint-common, angles, diagnostic-msgs, diagnostic-updater, eigen, eigen-stl-containers, eigen3-cmake-module, geographic-msgs, geographiclib, geometry-msgs, gtest, libmavconn, mavlink, mavros, mavros-msgs, message-filters, nav-msgs, pluginlib, python3Packages, rclcpp, rclcpp-components, rclpy, rcpputils, rosidl-default-runtime, sensor-msgs, std-msgs, std-srvs, tf2-eigen, tf2-ros, trajectory-msgs, urdf, visualization-msgs, yaml-cpp, yaml-cpp-vendor }:
buildRosPackage {
  pname = "ros-rolling-mavros-extras";
  version = "2.15.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mavros-release/archive/release/rolling/mavros_extras/2.15.1-1.tar.gz";
    name = "2.15.1-1.tar.gz";
    sha256 = "86fc4e90072e126078349fd3991e6b875abba754f37ee2bfecb75c0a58b72a4d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-python angles diagnostic-msgs diagnostic-updater eigen-stl-containers eigen3-cmake-module geographic-msgs geometry-msgs libmavconn mavlink mavros mavros-msgs message-filters nav-msgs pluginlib rclcpp rclcpp-components rcpputils sensor-msgs std-msgs std-srvs tf2-eigen tf2-ros trajectory-msgs urdf visualization-msgs yaml-cpp-vendor ];
  checkInputs = [ ament-cmake-gmock ament-cmake-gtest ament-cmake-pytest ament-lint-auto ament-lint-common gtest python3Packages.pytest ];
  propagatedBuildInputs = [ eigen geographiclib python3Packages.click yaml-cpp ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python eigen3-cmake-module ];
  rosBuildExportDepends = [ diagnostic-msgs diagnostic-updater eigen-stl-containers eigen3-cmake-module geographic-msgs geometry-msgs libmavconn mavlink mavros mavros-msgs message-filters nav-msgs pluginlib rclcpp rclcpp-components rcpputils sensor-msgs std-msgs std-srvs tf2-eigen tf2-ros trajectory-msgs urdf visualization-msgs yaml-cpp-vendor ];
  rosExecDepends = [ diagnostic-msgs diagnostic-updater eigen-stl-containers geographic-msgs geometry-msgs libmavconn mavros mavros-msgs message-filters nav-msgs pluginlib rclcpp rclcpp-components rclpy rcpputils rosidl-default-runtime sensor-msgs std-msgs std-srvs tf2-eigen tf2-ros trajectory-msgs urdf visualization-msgs yaml-cpp-vendor ];

  meta = {
    description = "Extra nodes and plugins for <a href=\"http://wiki.ros.org/mavros\">MAVROS</a>.";
    license = with lib.licenses; [ gpl3Only lgpl3Only bsdOriginal ];
  };
}
