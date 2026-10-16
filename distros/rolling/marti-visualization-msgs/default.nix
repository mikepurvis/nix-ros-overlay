
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, sensor-msgs }:
buildRosPackage {
  pname = "ros-rolling-marti-visualization-msgs";
  version = "1.6.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/marti_messages-release/archive/release/rolling/marti_visualization_msgs/1.6.1-2.tar.gz";
    name = "1.6.1-2.tar.gz";
    sha256 = "c083fafee4afe302fe5ccf10ab65de90a556153f0c82851fe1a90ddf3c3a6a32";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators sensor-msgs ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs sensor-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime sensor-msgs ];

  meta = {
    description = "marti_visualization_msgs";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
