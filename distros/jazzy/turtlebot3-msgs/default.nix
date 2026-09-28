
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-turtlebot3-msgs";
  version = "2.4.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/turtlebot3_msgs-release/archive/release/jazzy/turtlebot3_msgs/2.4.0-1.tar.gz";
    name = "2.4.0-1.tar.gz";
    sha256 = "f42117385175bf23ce6dd90ff775b65d08c584500b8f87f6c9311b7920d79173";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators rosidl-default-runtime std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosExecDepends = [ action-msgs builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "Message and service types: custom messages and services for TurtleBot3 packages for ROS 2";
    license = with lib.licenses; [ asl20 ];
  };
}
