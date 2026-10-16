
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-core, boost, gtest, lanelet2-core, lanelet2-io, lanelet2-matching, lanelet2-projection, lanelet2-routing, lanelet2-traffic-rules, mrt-cmake-modules }:
buildRosPackage {
  pname = "ros-rolling-lanelet2-python";
  version = "1.2.1-r7";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/lanelet2-release/archive/release/rolling/lanelet2_python/1.2.1-7.tar.gz";
    name = "1.2.1-7.tar.gz";
    sha256 = "060113671d68c02d858c3e5b14463f5b1db51ab1f33c5fdcfc532f64886ff2b2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-core lanelet2-core lanelet2-io lanelet2-matching lanelet2-projection lanelet2-routing lanelet2-traffic-rules mrt-cmake-modules ];
  checkInputs = [ gtest ];
  propagatedBuildInputs = [ boost ];
  nativeBuildInputs = [ ament-cmake-core mrt-cmake-modules ];
  rosBuildExportDepends = [ lanelet2-core lanelet2-io lanelet2-matching lanelet2-projection lanelet2-routing lanelet2-traffic-rules mrt-cmake-modules ];
  rosExecDepends = [ lanelet2-core lanelet2-io lanelet2-matching lanelet2-projection lanelet2-routing lanelet2-traffic-rules ];

  meta = {
    description = "Python bindings for lanelet2";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
