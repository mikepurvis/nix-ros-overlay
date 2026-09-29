
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-python, ament-cmake-ros, fastcdr, fmt, nlohmann_json, rmw, rosidl-generator-c, rosidl-runtime-c, rosidl-runtime-cpp, rosidl-typesupport-fastrtps-cpp, rosidl-typesupport-interface, rosidlcpp-generator-core, rosidlcpp-parser }:
buildRosPackage {
  pname = "ros-jazzy-rosidlcpp-typesupport-fastrtps-c";
  version = "0.5.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rosidlcpp-release/archive/release/jazzy/rosidlcpp_typesupport_fastrtps_c/0.5.0-1.tar.gz";
    name = "0.5.0-1.tar.gz";
    sha256 = "f3b5e5593f83a7c27a28036a66c4041ed62fdd6207c48cb35551b9e5c86fdf5b";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-python fastcdr rmw rosidl-runtime-c rosidl-typesupport-fastrtps-cpp rosidlcpp-generator-core rosidlcpp-parser ];
  propagatedBuildInputs = [ fmt nlohmann_json ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python ];
  rosBuildExportDepends = [ ament-cmake-ros fastcdr rmw rosidl-generator-c rosidl-runtime-c rosidl-runtime-cpp rosidl-typesupport-fastrtps-cpp rosidl-typesupport-interface rosidlcpp-generator-core rosidlcpp-parser ];

  meta = {
    description = "Generate the C interfaces for eProsima FastRTPS.";
    license = with lib.licenses; [ asl20 ];
  };
}
