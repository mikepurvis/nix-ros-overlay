
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, message-filters, pluginlib, qt5, rclcpp, rcpputils, rosidl-runtime-cpp }:
buildRosPackage {
  pname = "ros-jazzy-rqt-image-overlay-layer";
  version = "0.4.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rqt_image_overlay-release/archive/release/jazzy/rqt_image_overlay_layer/0.4.0-1.tar.gz";
    name = "0.4.0-1.tar.gz";
    sha256 = "b009ec12714f416eae221b22eb291edb5a43494216d517c52f1d6988c1dca972";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake message-filters pluginlib rclcpp rcpputils rosidl-runtime-cpp ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ qt5.qtbase ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ message-filters pluginlib rclcpp rcpputils rosidl-runtime-cpp ];

  meta = {
    description = "Provides an rqt_image_overlay_layer plugin interface, and a template impelementation class";
    license = with lib.licenses; [ asl20 ];
  };
}
