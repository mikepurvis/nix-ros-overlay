
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, builtin-interfaces, rmf-dispenser-msgs, rosidl-default-generators, rosidl-default-runtime }:
buildRosPackage {
  pname = "ros-rolling-rmf-ingestor-msgs";
  version = "4.0.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rmf_internal_msgs-release/archive/release/rolling/rmf_ingestor_msgs/4.0.0-2.tar.gz";
    name = "4.0.0-2.tar.gz";
    sha256 = "003428f7d47e70a3b68d4a683d133793f7a4b7dd948a8c5d2af61b61830cdc68";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces rmf-dispenser-msgs rosidl-default-generators ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces rmf-dispenser-msgs ];
  rosExecDepends = [ builtin-interfaces rmf-dispenser-msgs rosidl-default-runtime ];

  meta = {
    description = "A package containing messages used to interface to ingestor workcells";
    license = with lib.licenses; [ asl20 ];
  };
}
