
# Copyright 2021 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-index-cpp, ament-lint-auto, ament-lint-common, pluginlib, rcpputils, rmw, rmw-fastrtps-cpp, rosbag2-cpp, rosbag2-test-common, rosidl-runtime-cpp, test-msgs }:
buildRosPackage {
  pname = "ros-foxy-rosbag2-converter-default-plugins";
  version = "0.3.8-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rosbag2-release/archive/release/foxy/rosbag2_converter_default_plugins/0.3.8-1.tar.gz";
    name = "0.3.8-1.tar.gz";
    sha256 = "20bfa740b28fb280ceed092eb2ac7079131e570dc5fa6f78fa8ad93d2384ccbd";
  };

  buildType = "ament_cmake";
  checkInputs = [ ament-cmake-gmock ament-lint-auto ament-lint-common rcpputils rmw-fastrtps-cpp rosbag2-cpp rosbag2-test-common test-msgs ];
  propagatedBuildInputs = [ ament-index-cpp pluginlib rcpputils rmw rmw-fastrtps-cpp rosbag2-cpp rosidl-runtime-cpp ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''Package containing default plugins for format converters'';
    license = with lib.licenses; [ asl20 ];
  };
}
