
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-cppcheck, ament-cmake-gtest, ament-lint-auto, ament-lint-common, builtin-interfaces, geographic-msgs, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-tuw-geo-msgs";
  version = "0.2.6-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/tuw_msgs-release/archive/release/rolling/tuw_geo_msgs/0.2.6-2.tar.gz";
    name = "0.2.6-2.tar.gz";
    sha256 = "5b8259068c3dc9269de9f19225f3d98821c4939a6625228f5c6a095120df2ecd";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geographic-msgs geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-cmake-cppcheck ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geographic-msgs geometry-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geographic-msgs geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "The tuw_geo_msgs package";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
