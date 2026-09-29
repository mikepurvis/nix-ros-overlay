
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, rosgraph-monitor-msgs, rosidl-runtime-cpp, rosidl-typesupport-cpp }:
buildRosPackage {
  pname = "ros-jazzy-rmw-stats-shim";
  version = "0.2.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/graph_monitor-release/archive/release/jazzy/rmw_stats_shim/0.2.3-1.tar.gz";
    name = "0.2.3-1.tar.gz";
    sha256 = "88752eba9077a45666c31a70df450cf896c6049dc20a6fa1eb92748c2a697a91";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rosgraph-monitor-msgs rosidl-runtime-cpp rosidl-typesupport-cpp ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rosgraph-monitor-msgs rosidl-runtime-cpp rosidl-typesupport-cpp ];
  rosExecDepends = [ rosgraph-monitor-msgs rosidl-runtime-cpp rosidl-typesupport-cpp ];

  meta = {
    description = "Partial RMW shim library to instrument RMW API calls";
    license = with lib.licenses; [ asl20 ];
  };
}
