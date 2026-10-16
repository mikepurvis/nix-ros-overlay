
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, builtin-interfaces, rosidl-default-generators, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-urg-node-msgs";
  version = "1.0.1-r9";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/urg_node_msgs-release/archive/release/rolling/urg_node_msgs/1.0.1-9.tar.gz";
    name = "1.0.1-9.tar.gz";
    sha256 = "8c475574419017486621653da28f662b73f5c8acf53db8ce81fe88014bd66d56";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces rosidl-default-generators std-msgs ];
  rosExecDepends = [ builtin-interfaces rosidl-default-generators std-msgs ];

  meta = {
    description = "urg_node_msgs";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
