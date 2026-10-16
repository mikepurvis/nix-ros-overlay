
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, message-filters, pluginlib, qt5, rclcpp, rcpputils, rosidl-runtime-cpp }:
buildRosPackage {
  pname = "ros-rolling-rqt-image-overlay-layer";
  version = "0.5.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rqt_image_overlay-release/archive/release/rolling/rqt_image_overlay_layer/0.5.0-2.tar.gz";
    name = "0.5.0-2.tar.gz";
    sha256 = "517e35fc433e044aa6845f1ce1bb7ac702db153ed11d6665fb74f32f30ad7450";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake message-filters pluginlib rclcpp rcpputils rosidl-runtime-cpp ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ qt5.qtbase ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ message-filters pluginlib rclcpp rcpputils rosidl-runtime-cpp ];
  rosExecDepends = [ message-filters pluginlib rclcpp rcpputils rosidl-runtime-cpp ];

  meta = {
    description = "Provides an rqt_image_overlay_layer plugin interface, and a template impelementation class";
    license = with lib.licenses; [ asl20 ];
  };
}
