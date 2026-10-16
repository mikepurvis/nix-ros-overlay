
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, ecl-build, ecl-config, ecl-errors, ecl-license }:
buildRosPackage {
  pname = "ros-rolling-ecl-filesystem";
  version = "1.2.1-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ecl_core-release/archive/release/rolling/ecl_filesystem/1.2.1-5.tar.gz";
    name = "1.2.1-5.tar.gz";
    sha256 = "6287f99a89f02ec12e8d2a654bf65ffe5c6018454ddd1966e9593c5602112f7d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros ecl-build ecl-config ecl-errors ecl-license ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ ecl-build ecl-config ecl-errors ecl-license ];
  rosExecDepends = [ ecl-build ecl-config ecl-errors ecl-license ];

  meta = {
    description = "Cross platform filesystem utilities (until c++11 makes its way in).";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
