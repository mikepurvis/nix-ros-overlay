
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-cmake-ros, ament-lint-auto, autoware-cmake, autoware-lint-common, diagnostic-msgs, diagnostic-updater, rclcpp }:
buildRosPackage {
  pname = "ros-jazzy-autoware-utils-diagnostics";
  version = "1.9.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/autoware_utils-release/archive/release/jazzy/autoware_utils_diagnostics/1.9.0-1.tar.gz";
    name = "1.9.0-1.tar.gz";
    sha256 = "43494091424e3a3b2e6d4b42b20a8eab75ebd179acfbee159ff16b2fab30d436";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto autoware-cmake diagnostic-msgs diagnostic-updater rclcpp ];
  checkInputs = [ ament-cmake-ros ament-lint-auto autoware-lint-common ];
  nativeBuildInputs = [ ament-cmake-auto autoware-cmake ];
  rosBuildExportDepends = [ diagnostic-msgs diagnostic-updater rclcpp ];
  rosExecDepends = [ diagnostic-msgs diagnostic-updater rclcpp ];

  meta = {
    description = "The autoware_utils_diagnostics package";
    license = with lib.licenses; [ asl20 ];
  };
}
