
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-marine-acoustic-msgs";
  version = "2.1.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/marine_msgs-release/archive/release/rolling/marine_acoustic_msgs/2.1.0-2.tar.gz";
    name = "2.1.0-2.tar.gz";
    sha256 = "9270de23fd59ace5195de4ec3ff7fa655544dc6bbab2b90e8ff4f4c93bdc8dee";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake geometry-msgs rosidl-default-generators std-msgs ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ geometry-msgs std-msgs ];
  rosExecDepends = [ geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "The marine_acoustic_msgs package, including messages for common
  underwater sensors (DVL, multibeam sonar, imaging sonar)";
    license = with lib.licenses; [ bsd3 ];
  };
}
