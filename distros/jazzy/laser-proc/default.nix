
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, class-loader, rclcpp, rclcpp-components, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-laser-proc";
  version = "1.0.2-r7";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/laser_proc-release/archive/release/jazzy/laser_proc/1.0.2-7.tar.gz";
    name = "1.0.2-7.tar.gz";
    sha256 = "15077ba0c20c9c120c693b310ca8814e3b40ab17f56f7cd0736aa6fd1e86c24f";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake class-loader rclcpp rclcpp-components sensor-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ class-loader rclcpp rclcpp-components sensor-msgs ];
  rosExecDepends = [ class-loader rclcpp rclcpp-components sensor-msgs ];

  meta = {
    description = "laser_proc";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
