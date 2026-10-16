
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-core, boost, gtest, lanelet2-core, lanelet2-traffic-rules, mrt-cmake-modules }:
buildRosPackage {
  pname = "ros-rolling-lanelet2-routing";
  version = "1.2.1-r7";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/lanelet2-release/archive/release/rolling/lanelet2_routing/1.2.1-7.tar.gz";
    name = "1.2.1-7.tar.gz";
    sha256 = "931e5a172ed6c061cdba388bf969efc556dddd36f05a3a92c46eb472e5e431cb";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-core lanelet2-core lanelet2-traffic-rules mrt-cmake-modules ];
  checkInputs = [ gtest ];
  propagatedBuildInputs = [ boost ];
  nativeBuildInputs = [ ament-cmake-core mrt-cmake-modules ];
  rosBuildExportDepends = [ lanelet2-core lanelet2-traffic-rules mrt-cmake-modules ];
  rosExecDepends = [ lanelet2-core lanelet2-traffic-rules ];

  meta = {
    description = "Routing module for lanelet2";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
