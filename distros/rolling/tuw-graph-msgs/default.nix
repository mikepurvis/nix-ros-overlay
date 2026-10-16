
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-cppcheck, ament-cmake-gtest, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-tuw-graph-msgs";
  version = "0.2.6-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/tuw_msgs-release/archive/release/rolling/tuw_graph_msgs/0.2.6-2.tar.gz";
    name = "0.2.6-2.tar.gz";
    sha256 = "87c4113f2de485ed8d0e9e2fece1162db80d4b4fdafc19ab36ea9eab28a3d313";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-cmake-cppcheck ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "The tuw_graph_msgs package contains messages for sending graphs.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
