
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, geometry-msgs, mrpt-msgs, nav-msgs, rosidl-default-generators, rosidl-default-runtime }:
buildRosPackage {
  pname = "ros-rolling-mrpt-nav-interfaces";
  version = "2.5.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mrpt_navigation-release/archive/release/rolling/mrpt_nav_interfaces/2.5.0-1.tar.gz";
    name = "2.5.0-1.tar.gz";
    sha256 = "9922376ffea43b12d03b02dfcd0b8ba049d3b3dd8894beb7967274fcb6bdbf6f";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake geometry-msgs mrpt-msgs nav-msgs rosidl-default-generators ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs geometry-msgs mrpt-msgs nav-msgs ];
  rosExecDepends = [ action-msgs geometry-msgs mrpt-msgs nav-msgs rosidl-default-runtime ];

  meta = {
    description = "Message, services, and actions, for other mrpt navigation packages.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
