
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, builtin-interfaces, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-turtlebot3-applications-msgs";
  version = "1.0.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/turtlebot3_applications_msgs-release/archive/release/rolling/turtlebot3_applications_msgs/1.0.1-2.tar.gz";
    name = "1.0.1-2.tar.gz";
    sha256 = "bad3ccf59bd0d41fe3f13759c09a59b35d62d2e38ebe4c0b405963c45f955aa4";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces rosidl-default-generators sensor-msgs std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces sensor-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces rosidl-default-runtime sensor-msgs std-msgs ];

  meta = {
    description = "Message and service types: custom messages and services for TurtleBot3 Applications packages";
    license = with lib.licenses; [ asl20 ];
  };
}
