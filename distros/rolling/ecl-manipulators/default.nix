
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, ecl-build, ecl-exceptions, ecl-formatters, ecl-geometry, ecl-license }:
buildRosPackage {
  pname = "ros-rolling-ecl-manipulators";
  version = "1.2.1-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ecl_core-release/archive/release/rolling/ecl_manipulators/1.2.1-5.tar.gz";
    name = "1.2.1-5.tar.gz";
    sha256 = "85f340c924bbd7dcd1b1244ea50e4754503a2b85d5fb03f7575682724483be65";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros ecl-build ecl-exceptions ecl-formatters ecl-geometry ecl-license ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ ecl-build ecl-exceptions ecl-formatters ecl-geometry ecl-license ];
  rosExecDepends = [ ecl-build ecl-exceptions ecl-formatters ecl-geometry ecl-license ];

  meta = {
    description = "Deploys various manipulation algorithms, currently just
    feedforward filters (interpolations).";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
