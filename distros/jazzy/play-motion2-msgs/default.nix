
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, rosidl-default-generators, rosidl-default-runtime }:
buildRosPackage {
  pname = "ros-jazzy-play-motion2-msgs";
  version = "1.8.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/play_motion2-release/archive/release/jazzy/play_motion2_msgs/1.8.4-1.tar.gz";
    name = "1.8.4-1.tar.gz";
    sha256 = "85972c5fb2cb870e446b1d15f50bdb2904eab3ae119b7caecee5c9f86393b165";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces rosidl-default-generators ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces ];
  rosExecDepends = [ action-msgs builtin-interfaces rosidl-default-runtime ];

  meta = {
    description = "Play a pre-recorded motion on a robot";
    license = with lib.licenses; [ asl20 ];
  };
}
