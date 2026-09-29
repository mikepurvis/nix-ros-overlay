
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, angles, boost, builtin-interfaces, diagnostic-msgs, diagnostic-updater, eigen, geographic-msgs, geographiclib, geometry-msgs, launch-ros, launch-testing-ament-cmake, message-filters, nav-msgs, rclcpp, rmw-implementation, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs, std-srvs, tf2, tf2-eigen, tf2-geometry-msgs, tf2-ros, yaml-cpp-vendor }:
buildRosPackage {
  pname = "ros-jazzy-robot-localization";
  version = "3.8.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/robot_localization-release/archive/release/jazzy/robot_localization/3.8.3-1.tar.gz";
    name = "3.8.3-1.tar.gz";
    sha256 = "b9a64b727fb554242d73116ba29aad2b9c12030e6c4866c0976188ed1468da6d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake angles builtin-interfaces diagnostic-msgs diagnostic-updater geographic-msgs geometry-msgs message-filters nav-msgs rclcpp rmw-implementation rosidl-default-generators sensor-msgs std-msgs std-srvs tf2 tf2-eigen tf2-geometry-msgs tf2-ros yaml-cpp-vendor ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common launch-ros launch-testing-ament-cmake ];
  propagatedBuildInputs = [ boost eigen geographiclib ];
  nativeBuildInputs = [ ament-cmake builtin-interfaces rosidl-default-generators ];
  rosBuildExportDepends = [ angles diagnostic-msgs diagnostic-updater geographic-msgs geometry-msgs message-filters nav-msgs rclcpp rmw-implementation sensor-msgs std-msgs std-srvs tf2 tf2-eigen tf2-geometry-msgs tf2-ros yaml-cpp-vendor ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "Provides nonlinear state estimation through sensor fusion of an abritrary number of sensors.";
    license = with lib.licenses; [ asl20 ];
  };
}
