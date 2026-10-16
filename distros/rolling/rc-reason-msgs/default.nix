
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, geometry-msgs, rc-common-msgs, rosidl-default-generators, rosidl-default-runtime, shape-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-rc-reason-msgs";
  version = "0.5.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rc_reason_clients-release/archive/release/rolling/rc_reason_msgs/0.5.0-2.tar.gz";
    name = "0.5.0-2.tar.gz";
    sha256 = "c33bf5f1f507c63ee999ddfe3494c2adf64bc8bbed7462278be3514202abcca2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake geometry-msgs rc-common-msgs rosidl-default-generators shape-msgs std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ geometry-msgs rc-common-msgs shape-msgs std-msgs ];
  rosExecDepends = [ geometry-msgs rc-common-msgs rosidl-default-runtime shape-msgs std-msgs ];

  meta = {
    description = "Msg and srv definitions for rc_reason_clients";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
