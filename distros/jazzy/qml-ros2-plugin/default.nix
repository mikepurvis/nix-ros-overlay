
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-index-cpp, ament-lint-auto, example-interfaces, image-transport, qt5, rclcpp, ros-babel-fish, ros-babel-fish-test-msgs, std-srvs, tf2-ros, yaml-cpp }:
buildRosPackage {
  pname = "ros-jazzy-qml-ros2-plugin";
  version = "2.26.30-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/qml_ros2_plugin-release/archive/release/jazzy/qml_ros2_plugin/2.26.30-1.tar.gz";
    name = "2.26.30-1.tar.gz";
    sha256 = "174e4b6d26020eedff0c0972ebc7cc1e309353ddc7509dfd3668d1d7eb1bfaad";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-index-cpp image-transport rclcpp ros-babel-fish tf2-ros ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto example-interfaces qt5.qtquickcontrols2 ros-babel-fish-test-msgs std-srvs ];
  propagatedBuildInputs = [ qt5.qtbase qt5.qtdeclarative qt5.qtmultimedia yaml-cpp ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-index-cpp image-transport rclcpp ros-babel-fish tf2-ros ];
  rosExecDepends = [ ament-index-cpp image-transport rclcpp ros-babel-fish tf2-ros ];

  meta = {
    description = "A QML plugin for ROS.
    Enables full communication with ROS from QML.";
    license = with lib.licenses; [ mit ];
  };
}
