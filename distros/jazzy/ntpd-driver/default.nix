
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, poco, rclcpp, rclcpp-components, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-ntpd-driver";
  version = "2.2.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ntpd_driver-release/archive/release/jazzy/ntpd_driver/2.2.0-4.tar.gz";
    name = "2.2.0-4.tar.gz";
    sha256 = "ec3ab10b55db7a9060c224e4d06d75863ba12652fdb76acf2af188633691e0be";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp rclcpp-components sensor-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ poco ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "ntpd_driver sends TimeReference message time to ntpd server";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
