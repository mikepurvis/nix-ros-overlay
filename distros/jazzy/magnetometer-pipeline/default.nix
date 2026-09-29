
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gen-version-h, ament-cmake-gtest, ament-cmake-python, ament-cmake-ros, cras-cpp-common, cras-lint, eigen, message-filters, pluginlib, python3Packages, rclcpp, rclcpp-components, rclpy, sensor-msgs, std-msgs, std-srvs, tf2-eigen }:
buildRosPackage {
  pname = "ros-jazzy-magnetometer-pipeline";
  version = "4.0.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/compass-release/archive/release/jazzy/magnetometer_pipeline/4.0.1-1.tar.gz";
    name = "4.0.1-1.tar.gz";
    sha256 = "5404ce94ce55e3b94b23c2cadd687af614ba29fd48c42247672317da6a0f165d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-gen-version-h ament-cmake-python cras-cpp-common eigen message-filters pluginlib rclcpp rclcpp-components sensor-msgs tf2-eigen ];
  checkInputs = [ ament-cmake-gtest ament-cmake-ros cras-lint ];
  propagatedBuildInputs = [ python3Packages.numpy ];
  nativeBuildInputs = [ ament-cmake ament-cmake-gen-version-h ament-cmake-python ];
  rosBuildExportDepends = [ cras-cpp-common message-filters pluginlib rclcpp rclcpp-components sensor-msgs tf2-eigen ];
  rosExecDepends = [ cras-cpp-common message-filters pluginlib rclcpp rclcpp-components rclpy sensor-msgs std-msgs std-srvs tf2-eigen ];

  meta = {
    description = "Calibration and removing of magnetometer bias.";
    license = with lib.licenses; [ bsd3 ];
  };
}
