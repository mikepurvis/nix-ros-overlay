
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, ecl-build, ecl-converters, ecl-eigen, ecl-exceptions, ecl-formatters, ecl-license, ecl-math, sophus }:
buildRosPackage {
  pname = "ros-rolling-ecl-linear-algebra";
  version = "1.2.1-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ecl_core-release/archive/release/rolling/ecl_linear_algebra/1.2.1-5.tar.gz";
    name = "1.2.1-5.tar.gz";
    sha256 = "f180cccf30d9248883f326f5aa8dbc27a23ce234b89c8225456b9175b91fc1e4";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros ecl-build ecl-converters ecl-eigen ecl-exceptions ecl-formatters ecl-license ecl-math sophus ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ ecl-build ecl-converters ecl-eigen ecl-exceptions ecl-formatters ecl-license ecl-math sophus ];
  rosExecDepends = [ ecl-build ecl-converters ecl-eigen ecl-exceptions ecl-formatters ecl-license ecl-math sophus ];

  meta = {
    description = "Ecl frontend to a linear matrix package (currently eigen).";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
