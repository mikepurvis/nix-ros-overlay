
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, ecl-build, ecl-license }:
buildRosPackage {
  pname = "ros-jazzy-ecl-mpl";
  version = "1.2.1-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ecl_core-release/archive/release/jazzy/ecl_mpl/1.2.1-5.tar.gz";
    name = "1.2.1-5.tar.gz";
    sha256 = "aa3c94a0db2034b838bb28ef436e75737ec77ddd1b9678085f9befd4fba741de";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros ecl-build ecl-license ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ ecl-license ];

  meta = {
    description = "Metaprogramming tools move alot of runtime calculations to be shifted to
    compile time. This has only very elementary structures at this stage.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
