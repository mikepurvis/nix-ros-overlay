
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, boost, fmt, libcap, lifecycle-msgs, rclcpp, rclcpp-action, rclcpp-lifecycle, ros2-control-cmake, test-msgs }:
buildRosPackage {
  pname = "ros-rolling-realtime-tools";
  version = "5.3.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/realtime_tools-release/archive/release/rolling/realtime_tools/5.3.0-1.tar.gz";
    name = "5.3.0-1.tar.gz";
    sha256 = "4a6910cddfe30fec57e80eed25ee0c836db1d60bf49d4ba869f1d10973c25128";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp rclcpp-action ros2-control-cmake ];
  checkInputs = [ ament-cmake-gmock lifecycle-msgs rclcpp-lifecycle test-msgs ];
  propagatedBuildInputs = [ boost fmt libcap ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-cmake rclcpp rclcpp-action ];
  rosExecDepends = [ rclcpp rclcpp-action ];

  meta = {
    description = "Contains a set of tools that can be used from a hard
    realtime thread, without breaking the realtime behavior.";
    license = with lib.licenses; [ bsd3 ];
  };
}
