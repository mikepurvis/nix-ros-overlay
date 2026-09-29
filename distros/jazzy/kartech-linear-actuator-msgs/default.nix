
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, ros-environment, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-kartech-linear-actuator-msgs";
  version = "4.0.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/astuff_sensor_msgs-release/archive/release/jazzy/kartech_linear_actuator_msgs/4.0.0-4.tar.gz";
    name = "4.0.0-4.tar.gz";
    sha256 = "90c49e9356c347049adf4efc40f9dc92f69373e68850146eba630f2e8ebe93dd";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces ros-environment rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "The kartech_linear_actuator_msgs package";
    license = with lib.licenses; [ mit ];
  };
}
