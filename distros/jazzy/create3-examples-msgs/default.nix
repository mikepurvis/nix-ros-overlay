
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-common, builtin-interfaces, rosidl-default-generators, rosidl-default-runtime }:
buildRosPackage {
  pname = "ros-jazzy-create3-examples-msgs";
  version = "1.0.0-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/create3_examples-release/archive/release/jazzy/create3_examples_msgs/1.0.0-1.tar.gz";
    name = "1.0.0-1.tar.gz";
    sha256 = "0ef99687f0220f5c187f3311e13100e87df258a273f6893e2a6dc1a2de7b24f8";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces rosidl-default-generators ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosExecDepends = [ action-msgs builtin-interfaces rosidl-default-runtime ];

  meta = {
    description = "Package containing action, message and service definitions used by the iRobot(R) Create(R) 3 examples";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
