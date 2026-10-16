
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-core, ament-cmake-ros-core, ament-index-python, fmt, nlohmann_json, rcpputils, rcutils, ros-environment, rosidl-cli, rosidl-generator-c, rosidl-pycommon, rosidl-runtime-c, rosidl-typesupport-interface, rosidl-typesupport-introspection-c, rosidlcpp-generator-core, rosidlcpp-parser }:
buildRosPackage {
  pname = "ros-rolling-rosidlcpp-typesupport-c";
  version = "0.6.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rosidlcpp-release/archive/release/rolling/rosidlcpp_typesupport_c/0.6.0-1.tar.gz";
    name = "0.6.0-1.tar.gz";
    sha256 = "a0016d7a9422a8422d7b410a445c5f024713bf50bd620bc4fffb9aba8beee0bb";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros-core rcpputils rcutils ros-environment rosidl-runtime-c rosidl-typesupport-introspection-c rosidlcpp-generator-core rosidlcpp-parser ];
  propagatedBuildInputs = [ fmt nlohmann_json ];
  nativeBuildInputs = [ ament-cmake-ros-core ];
  rosBuildExportDepends = [ ament-cmake-core rcpputils rcutils rosidl-runtime-c rosidlcpp-generator-core rosidlcpp-parser ];
  rosExecDepends = [ ament-index-python rcpputils rcutils rosidl-cli rosidl-generator-c rosidl-pycommon rosidl-typesupport-interface rosidlcpp-generator-core rosidlcpp-parser ];

  meta = {
    description = "Generate the type support for C messages.";
    license = with lib.licenses; [ asl20 ];
  };
}
