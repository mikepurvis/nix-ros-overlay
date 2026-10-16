
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, ros-environment, rosidl-default-generators, rosidl-default-runtime, shape-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-derived-object-msgs";
  version = "4.0.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/astuff_sensor_msgs-release/archive/release/rolling/derived_object_msgs/4.0.0-4.tar.gz";
    name = "4.0.0-4.tar.gz";
    sha256 = "1ff21c96daeccee352548d00c0ccc0b38e2c056b7d6ddd35ddee3f40a3abda1d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs ros-environment rosidl-default-generators shape-msgs std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs shape-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime shape-msgs std-msgs ];

  meta = {
    description = "Abstracted Messages from Perception Modalities";
    license = with lib.licenses; [ mit ];
  };
}
