
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common }:
buildRosPackage {
  pname = "ros-rolling-tlsf";
  version = "0.12.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/tlsf-release/archive/release/rolling/tlsf/0.12.1-1.tar.gz";
    name = "0.12.1-1.tar.gz";
    sha256 = "b49d15dc519077c59dfd2a5e20f23e833698047704a576a8c382ddb9a8455038";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ ament-cmake ];
  rosExecDepends = [ ament-cmake ];

  meta = {
    description = "TLSF allocator version 2.4.6";
    license = with lib.licenses; [ lgpl21Only ];
  };
}
