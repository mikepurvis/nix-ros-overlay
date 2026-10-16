
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-lint-auto, ament-lint-common, autoware-common-msgs, builtin-interfaces, diagnostic-msgs, geometry-msgs, nav-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs, unique-identifier-msgs }:
buildRosPackage {
  pname = "ros-rolling-autoware-system-msgs";
  version = "1.12.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/autoware_msgs-release/archive/release/rolling/autoware_system_msgs/1.12.0-1.tar.gz";
    name = "1.12.0-1.tar.gz";
    sha256 = "29ccef442498ddebf71cd88ec3104a616fb7dddea982b7c12e1d286c064f2d5e";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto autoware-common-msgs builtin-interfaces diagnostic-msgs geometry-msgs nav-msgs rosidl-default-generators std-msgs unique-identifier-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ autoware-common-msgs builtin-interfaces diagnostic-msgs geometry-msgs nav-msgs std-msgs unique-identifier-msgs ];
  rosExecDepends = [ autoware-common-msgs builtin-interfaces diagnostic-msgs geometry-msgs nav-msgs rosidl-default-runtime std-msgs unique-identifier-msgs ];

  meta = {
    description = "Autoware system messages package.";
    license = with lib.licenses; [ asl20 ];
  };
}
