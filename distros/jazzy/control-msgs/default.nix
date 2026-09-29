
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs, trajectory-msgs }:
buildRosPackage {
  pname = "ros-jazzy-control-msgs";
  version = "5.10.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/control_msgs-release/archive/release/jazzy/control_msgs/5.10.0-1.tar.gz";
    name = "5.10.0-1.tar.gz";
    sha256 = "a745af3aa1065380edc167925e2c31b601f12d1d4d9e495a8656678361a6e3db";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators sensor-msgs std-msgs trajectory-msgs ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs sensor-msgs std-msgs trajectory-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "control_msgs contains base messages and actions useful for
    controlling robots. It provides representations for controller
    setpoints and joint and cartesian trajectories.";
    license = with lib.licenses; [ bsd3 ];
  };
}
