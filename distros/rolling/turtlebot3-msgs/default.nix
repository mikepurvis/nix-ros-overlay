
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-turtlebot3-msgs";
  version = "2.4.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/turtlebot3_msgs-release/archive/release/rolling/turtlebot3_msgs/2.4.0-2.tar.gz";
    name = "2.4.0-2.tar.gz";
    sha256 = "5c26226a0ed7fe822605024abe2d71f61ef088c9b863adbaef3578c511b997cd";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators rosidl-default-runtime std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];
  rosExecDepends = [ action-msgs builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "Message and service types: custom messages and services for TurtleBot3 packages for ROS 2";
    license = with lib.licenses; [ asl20 ];
  };
}
