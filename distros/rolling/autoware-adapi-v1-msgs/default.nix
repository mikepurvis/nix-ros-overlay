
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-lint-auto, ament-lint-common, builtin-interfaces, geographic-msgs, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, shape-msgs, std-msgs, unique-identifier-msgs }:
buildRosPackage {
  pname = "ros-rolling-autoware-adapi-v1-msgs";
  version = "1.9.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/autoware_adapi_msgs-release/archive/release/rolling/autoware_adapi_v1_msgs/1.9.1-1.tar.gz";
    name = "1.9.1-1.tar.gz";
    sha256 = "f33fa94311b9bf7f4afb378142d74386856f66ea0c2f09de8f01b39e19ab692d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto builtin-interfaces geographic-msgs geometry-msgs rosidl-default-generators shape-msgs std-msgs unique-identifier-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ builtin-interfaces geographic-msgs geometry-msgs shape-msgs std-msgs unique-identifier-msgs ];
  rosExecDepends = [ builtin-interfaces geographic-msgs geometry-msgs rosidl-default-runtime shape-msgs std-msgs unique-identifier-msgs ];

  meta = {
    description = "The Autoware AD API interfaces";
    license = with lib.licenses; [ asl20 ];
  };
}
