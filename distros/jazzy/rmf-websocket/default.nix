
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-catch2, ament-cmake-uncrustify, boost, eigen, nlohmann-json-schema-validator-vendor, nlohmann_json, rclcpp, rmf-utils, websocketpp }:
buildRosPackage {
  pname = "ros-jazzy-rmf-websocket";
  version = "2.7.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rmf_ros2-release/archive/release/jazzy/rmf_websocket/2.7.2-1.tar.gz";
    name = "2.7.2-1.tar.gz";
    sha256 = "0333319338ddbd2f04ec5f75e6dc35d735dd33756c60ac43130b69f9f9fafcb2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake eigen nlohmann-json-schema-validator-vendor rclcpp rmf-utils ];
  checkInputs = [ ament-cmake-catch2 ament-cmake-uncrustify ];
  propagatedBuildInputs = [ boost nlohmann_json websocketpp ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ nlohmann-json-schema-validator-vendor rclcpp rmf-utils ];

  meta = {
    description = "A package managing the websocket api endpoints in RMF system.";
    license = with lib.licenses; [ asl20 ];
  };
}
