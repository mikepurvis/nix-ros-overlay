
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gen-version-h, ament-cmake-gmock, backward-ros, control-msgs, fmt, joint-limits, lifecycle-msgs, pal-statistics, pluginlib, rclcpp-lifecycle, rcpputils, rcutils, realtime-tools, ros2-control-cmake, ros2-control-test-assets, sdformat-urdf, tinyxml-2, urdf }:
buildRosPackage {
  pname = "ros-rolling-hardware-interface";
  version = "6.10.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ros2_control-release/archive/release/rolling/hardware_interface/6.10.1-1.tar.gz";
    name = "6.10.1-1.tar.gz";
    sha256 = "df71a6ef62adf3bbc07efc01b59f589b22efe7531958b77cea24f24b0eb183d8";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-gen-version-h backward-ros control-msgs joint-limits lifecycle-msgs pal-statistics pluginlib rclcpp-lifecycle rcpputils rcutils realtime-tools ros2-control-cmake sdformat-urdf urdf ];
  checkInputs = [ ament-cmake-gmock ros2-control-test-assets ];
  propagatedBuildInputs = [ fmt tinyxml-2 ];
  nativeBuildInputs = [ ament-cmake ament-cmake-gen-version-h ];
  rosBuildExportDepends = [ backward-ros control-msgs joint-limits lifecycle-msgs pal-statistics pluginlib rclcpp-lifecycle rcpputils rcutils realtime-tools sdformat-urdf urdf ];
  rosExecDepends = [ backward-ros control-msgs joint-limits lifecycle-msgs pal-statistics pluginlib rclcpp-lifecycle rcpputils rcutils realtime-tools sdformat-urdf urdf ];

  meta = {
    description = "Base classes for hardware abstraction and tooling for them";
    license = with lib.licenses; [ asl20 ];
  };
}
