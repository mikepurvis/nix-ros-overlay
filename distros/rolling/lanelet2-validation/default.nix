
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-core, gtest, lanelet2-core, lanelet2-io, lanelet2-maps, lanelet2-projection, lanelet2-routing, lanelet2-traffic-rules, mrt-cmake-modules }:
buildRosPackage {
  pname = "ros-rolling-lanelet2-validation";
  version = "1.2.1-r7";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/lanelet2-release/archive/release/rolling/lanelet2_validation/1.2.1-7.tar.gz";
    name = "1.2.1-7.tar.gz";
    sha256 = "332c92bf81d5c942b7354a867f2e6e7e49b18c08329a88c286f45eafeff4cbcd";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-core lanelet2-core lanelet2-io lanelet2-projection lanelet2-routing lanelet2-traffic-rules mrt-cmake-modules ];
  checkInputs = [ gtest lanelet2-maps ];
  nativeBuildInputs = [ ament-cmake-core mrt-cmake-modules ];
  rosBuildExportDepends = [ lanelet2-core lanelet2-io lanelet2-projection lanelet2-routing lanelet2-traffic-rules mrt-cmake-modules ];
  rosExecDepends = [ lanelet2-core lanelet2-io lanelet2-projection lanelet2-routing lanelet2-traffic-rules ];

  meta = {
    description = "Package for sanitizing lanelet maps";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
