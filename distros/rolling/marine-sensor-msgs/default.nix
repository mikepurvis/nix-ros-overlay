
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-marine-sensor-msgs";
  version = "2.1.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/marine_msgs-release/archive/release/rolling/marine_sensor_msgs/2.1.0-2.tar.gz";
    name = "2.1.0-2.tar.gz";
    sha256 = "0d2963f0825c8ca2719da1088ab325daa729a3cf10bfd73f30cafc503d301fe2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "The marine_sensor_msgs package, meant to contain messages for common
  underwater sensors (e.g., conductivity, turbidity, dissolved oxygen)";
    license = with lib.licenses; [ bsd3 ];
  };
}
