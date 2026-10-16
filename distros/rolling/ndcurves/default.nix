
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, boost, cmake, doxygen, eigen, eigenpy, git, graphviz, jrl-cmakemodules, pinocchio }:
buildRosPackage {
  pname = "ros-rolling-ndcurves";
  version = "2.3.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ndcurves-release/archive/release/rolling/ndcurves/2.3.0-1.tar.gz";
    name = "2.3.0-1.tar.gz";
    sha256 = "7e6fc7fd1b460a84a6713dffc3f5043765503423b1d386c6cc6d3318e7a37c34";
  };

  buildType = "cmake";
  buildInputs = [ cmake doxygen eigenpy git jrl-cmakemodules pinocchio ];
  propagatedBuildInputs = [ boost eigen graphviz ];
  nativeBuildInputs = [ cmake ];
  rosBuildExportDepends = [ eigenpy jrl-cmakemodules pinocchio ];
  rosExecDepends = [ ament-cmake eigenpy jrl-cmakemodules pinocchio ];

  meta = {
    description = "A template-based Library for creating curves of arbitrary order and dimension";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
