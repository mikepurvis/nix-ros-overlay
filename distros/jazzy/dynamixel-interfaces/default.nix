
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-dynamixel-interfaces";
  version = "1.0.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/dynamixel_interfaces-release/archive/release/jazzy/dynamixel_interfaces/1.0.1-1.tar.gz";
    name = "1.0.1-1.tar.gz";
    sha256 = "bec8c8e31e423145cf419b3324d3b7288b021f8da79869cab31e60ff9e07b796";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "dynamixel_interfaces contains base messages and service useful for controlling Dynamixel.";
    license = with lib.licenses; [ asl20 ];
  };
}
