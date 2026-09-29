
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-index-cpp, ament-lint-auto, libGL, libGLU, nlohmann_json, qml6-ros2-plugin, qt6, ros-babel-fish-test-msgs, yaml-cpp-vendor }:
buildRosPackage {
  pname = "ros-jazzy-rqml-core";
  version = "3.26.42-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rqml-release/archive/release/jazzy/rqml_core/3.26.42-1.tar.gz";
    name = "3.26.42-1.tar.gz";
    sha256 = "728f4c756ebe18e8b928de11dfb84160190ba58f959b63a39a195c77998f1542";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-index-cpp libGL libGLU nlohmann_json qml6-ros2-plugin yaml-cpp-vendor ];
  checkInputs = [ ament-lint-auto ros-babel-fish-test-msgs ];
  propagatedBuildInputs = [ qt6.qtbase qt6.qtdeclarative ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-index-cpp qml6-ros2-plugin yaml-cpp-vendor ];

  meta = {
    description = "QML-based robotics visualization and control tool for ROS 2.";
    license = with lib.licenses; [ gpl3Only ];
  };
}
