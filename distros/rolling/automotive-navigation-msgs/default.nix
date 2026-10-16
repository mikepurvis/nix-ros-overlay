
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, ros-environment, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-automotive-navigation-msgs";
  version = "3.0.4-r6";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/automotive_autonomy_msgs-release/archive/release/rolling/automotive_navigation_msgs/3.0.4-6.tar.gz";
    name = "3.0.4-6.tar.gz";
    sha256 = "228c90c68249077e39ac3826257089989e89b09665e3f2ec6de17cf0a3ceaf3a";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs ros-environment rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "Generic Messages for Navigation Objectives in Automotive Automation Software";
    license = with lib.licenses; [ mit ];
  };
}
