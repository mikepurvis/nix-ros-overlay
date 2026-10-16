
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-index-cpp, camera-calibration-parsers, cv-bridge, eigen, image-geometry, image-transport, message-filters, opencv, rcl-interfaces, rclcpp, rclcpp-components, rclpy, swri-geometry-util, swri-math-util, swri-opencv-util, tf2 }:
buildRosPackage {
  pname = "ros-rolling-swri-image-util";
  version = "3.11.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/marti_common-release/archive/release/rolling/swri_image_util/3.11.0-1.tar.gz";
    name = "3.11.0-1.tar.gz";
    sha256 = "cbe66293e11fc18a6030b8561b34a7c13d174dc40b7947b874655a5dd22849cb";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-index-cpp camera-calibration-parsers cv-bridge image-geometry image-transport message-filters rcl-interfaces rclcpp rclcpp-components rclpy swri-geometry-util swri-math-util swri-opencv-util tf2 ];
  checkInputs = [ ament-cmake-gtest ];
  propagatedBuildInputs = [ eigen opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-index-cpp camera-calibration-parsers cv-bridge image-geometry image-transport message-filters rcl-interfaces rclcpp rclcpp-components rclpy swri-geometry-util swri-math-util swri-opencv-util tf2 ];
  rosExecDepends = [ ament-index-cpp camera-calibration-parsers cv-bridge image-geometry image-transport message-filters rcl-interfaces rclcpp rclcpp-components rclpy swri-geometry-util swri-math-util swri-opencv-util tf2 ];

  meta = {
    description = "A package of commonly image manipulation utilities.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
