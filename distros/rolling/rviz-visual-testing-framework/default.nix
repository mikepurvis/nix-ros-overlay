
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-cmake-gtest, ament-cmake-ros-core, ament-lint-auto, ament-lint-common, geometry-msgs, qt6, rclcpp, rcutils, rviz-common, rviz-ogre-vendor, rviz-rendering, std-msgs, tf2, tf2-ros }:
buildRosPackage {
  pname = "ros-rolling-rviz-visual-testing-framework";
  version = "16.0.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rviz-release/archive/release/rolling/rviz_visual_testing_framework/16.0.3-1.tar.gz";
    name = "16.0.3-1.tar.gz";
    sha256 = "649c0d3a8e222fe082cd1b60f3e8520119a7f42e0450624ab38c1961d72a1cc9";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-gtest ament-cmake-ros-core geometry-msgs qt6.qtbase rclcpp rcutils rviz-common rviz-ogre-vendor rviz-rendering std-msgs tf2 tf2-ros ];
  checkInputs = [ ament-cmake-gmock ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros-core ];
  rosBuildExportDepends = [ ament-cmake-gtest ament-cmake-ros-core geometry-msgs rclcpp rcutils rviz-common rviz-ogre-vendor rviz-rendering std-msgs tf2 tf2-ros ];
  rosExecDepends = [ ament-cmake-gtest geometry-msgs rclcpp rcutils rviz-common rviz-ogre-vendor rviz-rendering std-msgs tf2 tf2-ros ];

  meta = {
    description = "3D testing framework for RViz.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
