
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, ros-environment, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-automotive-navigation-msgs";
  version = "3.0.4-r6";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/automotive_autonomy_msgs-release/archive/release/jazzy/automotive_navigation_msgs/3.0.4-6.tar.gz";
    name = "3.0.4-6.tar.gz";
    sha256 = "b21dbdd15fb66f8012cbdfcd7470d0fb0f9075b6d7478d15257258222c699c6f";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs ros-environment rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "Generic Messages for Navigation Objectives in Automotive Automation Software";
    license = with lib.licenses; [ mit ];
  };
}
