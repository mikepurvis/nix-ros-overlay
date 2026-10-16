
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-black, ament-cmake-copyright, ament-cmake-core, ament-cmake-lint-cmake, ament-cmake-test, ament-cmake-xmllint }:
buildRosPackage {
  pname = "ros-rolling-ament-cmake-black";
  version = "0.2.7-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ament_black-release/archive/release/rolling/ament_cmake_black/0.2.7-1.tar.gz";
    name = "0.2.7-1.tar.gz";
    sha256 = "c3924eac852ec1e76ff1aaeef1837d4356bd8956c7e8fc7de15d42a566d169f8";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-core ament-cmake-test ];
  checkInputs = [ ament-cmake-copyright ament-cmake-lint-cmake ament-cmake-xmllint ];
  nativeBuildInputs = [ ament-cmake-core ament-cmake-test ];
  rosBuildExportDepends = [ ament-black ament-cmake-test ];

  meta = {
    description = "The CMake API for ament_black to lint Python code using black.";
    license = with lib.licenses; [ asl20 ];
  };
}
