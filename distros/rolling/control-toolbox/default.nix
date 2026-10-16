
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, backward-ros, control-msgs, eigen, filters, fmt, generate-parameter-library, geometry-msgs, pluginlib, rclcpp, rclcpp-lifecycle, rcutils, realtime-tools, ros2-control-cmake, rsl, tf2, tf2-geometry-msgs, tf2-ros, tl-expected-nixpkgs }:
buildRosPackage {
  pname = "ros-rolling-control-toolbox";
  version = "6.4.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/control_toolbox-release/archive/release/rolling/control_toolbox/6.4.0-1.tar.gz";
    name = "6.4.0-1.tar.gz";
    sha256 = "0ab98cfd03052465104bc5ce95a06bd62f94d24714dbbf8a75fed59d6b85a474";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake backward-ros control-msgs filters fmt generate-parameter-library geometry-msgs pluginlib rclcpp rcutils realtime-tools ros2-control-cmake rsl tf2 tf2-geometry-msgs tf2-ros ];
  checkInputs = [ ament-cmake-gmock rclcpp-lifecycle ];
  propagatedBuildInputs = [ eigen tl-expected-nixpkgs ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ backward-ros control-msgs filters generate-parameter-library geometry-msgs pluginlib rclcpp rcutils realtime-tools rsl tf2 tf2-geometry-msgs tf2-ros ];
  rosExecDepends = [ backward-ros control-msgs filters generate-parameter-library geometry-msgs pluginlib rclcpp rcutils realtime-tools rsl tf2 tf2-geometry-msgs tf2-ros ];

  meta = {
    description = "The control toolbox contains modules that are useful across all controllers.";
    license = with lib.licenses; [ asl20 ];
  };
}
