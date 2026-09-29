
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, cv-bridge, filters, grid-map-cmake-helpers, grid-map-core, pluginlib, rclcpp, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-grid-map-cv";
  version = "2.2.2-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/grid_map-release/archive/release/jazzy/grid_map_cv/2.2.2-2.tar.gz";
    name = "2.2.2-2.tar.gz";
    sha256 = "f11a83da9014423464e04da4b101c738ab03d71d8adfed5b1d9da493b2712e13";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake cv-bridge filters grid-map-cmake-helpers grid-map-core pluginlib rclcpp sensor-msgs ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ cv-bridge filters grid-map-core pluginlib rclcpp sensor-msgs ];
  rosExecDepends = [ cv-bridge filters grid-map-core pluginlib rclcpp sensor-msgs ];

  meta = {
    description = "Conversions between grid maps and OpenCV images.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
