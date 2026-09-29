
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, cmake, eigen, libGL, libGLU, mrpt-img, mrpt-poses, mrpt-viz }:
buildRosPackage {
  pname = "ros-jazzy-mrpt-opengl";
  version = "3.1.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mrpt3-release/archive/release/jazzy/mrpt_opengl/3.1.4-1.tar.gz";
    name = "3.1.4-1.tar.gz";
    sha256 = "d5fe56447341bfd761f621160fd19461cbe9de238eeacb5259d0adc799bd768c";
  };

  buildType = "cmake";
  buildInputs = [ cmake eigen mrpt-img mrpt-poses mrpt-viz ];
  propagatedBuildInputs = [ libGL libGLU ];
  nativeBuildInputs = [ cmake ];
  rosBuildExportDepends = [ mrpt-img mrpt-poses mrpt-viz ];

  meta = {
    description = "The MRPT C++ library mrpt_opengl";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
