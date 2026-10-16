
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-cmake-gtest, ament-cmake-ros-core, ament-index-cpp, ament-lint-auto, ament-lint-common, qt6, resource-retriever, rviz-rendering }:
buildRosPackage {
  pname = "ros-rolling-rviz-rendering-tests";
  version = "16.0.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rviz-release/archive/release/rolling/rviz_rendering_tests/16.0.3-1.tar.gz";
    name = "16.0.3-1.tar.gz";
    sha256 = "39a72d72771ba25785e752c3a7dbccf3b6cdd9724f765ee1c2c24d019295e858";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-ros-core qt6.qtbase resource-retriever rviz-rendering ];
  checkInputs = [ ament-cmake-gmock ament-cmake-gtest ament-index-cpp ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros-core ];
  rosBuildExportDepends = [ resource-retriever rviz-rendering ];
  rosExecDepends = [ resource-retriever rviz-rendering ];

  meta = {
    description = "Example plugin for RViz - documents and tests RViz plugin development";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
