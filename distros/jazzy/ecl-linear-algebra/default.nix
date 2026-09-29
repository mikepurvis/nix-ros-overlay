
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, ecl-build, ecl-converters, ecl-eigen, ecl-exceptions, ecl-formatters, ecl-license, ecl-math, sophus }:
buildRosPackage {
  pname = "ros-jazzy-ecl-linear-algebra";
  version = "1.2.1-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ecl_core-release/archive/release/jazzy/ecl_linear_algebra/1.2.1-5.tar.gz";
    name = "1.2.1-5.tar.gz";
    sha256 = "a321eb1fb8f7b176971a46e70cd4d2976a0eea7ca50deffcad25068f1dc01351";
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
