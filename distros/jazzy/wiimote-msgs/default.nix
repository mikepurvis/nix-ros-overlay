
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-auto, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-wiimote-msgs";
  version = "3.3.0-r3";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/joystick_drivers-release/archive/release/jazzy/wiimote_msgs/3.3.0-3.tar.gz";
    name = "3.3.0-3.tar.gz";
    sha256 = "0c506fd4a716c2b1c6004749b9a0edd2a37aaa10f57ec3bfc8bc45711c0aba69";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-auto builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-auto rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "Messages used by wiimote package.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
