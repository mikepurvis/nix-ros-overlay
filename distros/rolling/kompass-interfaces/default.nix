
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, builtin-interfaces, geometry-msgs, nav-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-kompass-interfaces";
  version = "0.6.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/kompass-release/archive/release/rolling/kompass_interfaces/0.6.0-1.tar.gz";
    name = "0.6.0-1.tar.gz";
    sha256 = "1746b6bb87887f7bca831b49aa5a524f19515c81134af922c109873784e1e12c";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs nav-msgs rosidl-default-generators std-msgs ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs nav-msgs std-msgs ];
  rosExecDepends = [ action-msgs builtin-interfaces geometry-msgs nav-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "ROS2 Interfaces for Kompass";
    license = with lib.licenses; [ mit ];
  };
}
