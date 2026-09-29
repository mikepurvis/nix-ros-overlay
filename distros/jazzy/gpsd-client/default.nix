
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, gps-msgs, gpsd, pkg-config, rclcpp, rclcpp-components, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-gpsd-client";
  version = "3.1.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/gps_umd-release/archive/release/jazzy/gpsd_client/3.1.1-1.tar.gz";
    name = "3.1.1-1.tar.gz";
    sha256 = "464ef5c957cf2fcfa6acb82a60342b4d80445bc05df3e74a620d1fc63325ba17";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake gps-msgs rclcpp rclcpp-components sensor-msgs ];
  checkInputs = [ ament-cmake-gtest ];
  propagatedBuildInputs = [ gpsd pkg-config ];
  nativeBuildInputs = [ ament-cmake pkg-config ];
  rosBuildExportDepends = [ gps-msgs rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ gps-msgs rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "connects to a GPSd server and broadcasts GPS fixes 
   using the NavSatFix message";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
