
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-simulation-interfaces";
  version = "2.1.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/simulation_interfaces-release/archive/release/rolling/simulation_interfaces/2.1.0-2.tar.gz";
    name = "2.1.0-2.tar.gz";
    sha256 = "216067eec22990be2e9bae247c8ac78e0f38a8ad2afd181b08212100761c32ce";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ action-msgs builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "A package containing simulation interfaces including messages, services and actions";
    license = with lib.licenses; [ asl20 ];
  };
}
