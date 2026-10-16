
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, rosgraph-monitor-msgs, rosidl-runtime-cpp, rosidl-typesupport-cpp }:
buildRosPackage {
  pname = "ros-rolling-rmw-stats-shim";
  version = "0.2.3-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/graph_monitor-release/archive/release/rolling/rmw_stats_shim/0.2.3-2.tar.gz";
    name = "0.2.3-2.tar.gz";
    sha256 = "1633bb8fefb75f20ac746dbed0fa88c426686ba16e711e56351e4713dbbd454a";
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
