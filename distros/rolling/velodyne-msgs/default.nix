
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-velodyne-msgs";
  version = "2.5.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/velodyne-release/archive/release/rolling/velodyne_msgs/2.5.1-2.tar.gz";
    name = "2.5.1-2.tar.gz";
    sha256 = "da1dddd2cc2d30d848d32577033f501c31628b279a2ad4361c8718f2892bd663";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces std-msgs ];
  rosExecDepends = [ builtin-interfaces rosidl-default-runtime std-msgs ];

  meta = {
    description = "ROS message definitions for Velodyne 3D LIDARs.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
