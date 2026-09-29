
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-urinterfaces";
  version = "9.0.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/urinterfaces-release/archive/release/jazzy/urinterfaces/9.0.0-1.tar.gz";
    name = "9.0.0-1.tar.gz";
    sha256 = "1017721665b5ee9b3924ce86e0671695fc53d157422ba9912dab916b8a40c9a2";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators sensor-msgs std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces geometry-msgs sensor-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "A package containing ROS2 ur message definitions.";
    license = with lib.licenses; [ bsd3 ];
  };
}
