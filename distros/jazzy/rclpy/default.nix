
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-cmake-gtest, ament-cmake-pytest, ament-index-python, ament-lint-auto, ament-lint-common, builtin-interfaces, lifecycle-msgs, pybind11-vendor, python-cmake-module, python3Packages, rcl, rcl-action, rcl-interfaces, rcl-lifecycle, rcl-logging-interface, rcl-yaml-param-parser, rcpputils, rcutils, rmw, rmw-implementation, rmw-implementation-cmake, rosgraph-msgs, rosidl-generator-py, rosidl-runtime-c, rpyutils, test-msgs, unique-identifier-msgs }:
buildRosPackage {
  pname = "ros-jazzy-rclpy";
  version = "7.1.12-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rclpy-release/archive/release/jazzy/rclpy/7.1.12-1.tar.gz";
    name = "7.1.12-1.tar.gz";
    sha256 = "73262f3ee5fb2c38a2037d8489706d287e261c73cf622f3b5b65391a5a1dbc58";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake lifecycle-msgs pybind11-vendor python-cmake-module rcl rcl-action rcl-interfaces rcl-lifecycle rcl-logging-interface rcl-yaml-param-parser rcpputils rcutils rmw rmw-implementation rmw-implementation-cmake rosidl-runtime-c unique-identifier-msgs ];
  checkInputs = [ ament-cmake-gtest ament-cmake-pytest ament-lint-auto ament-lint-common python3Packages.pytest rosidl-generator-py test-msgs ];
  propagatedBuildInputs = [ python3Packages.pyyaml ];
  nativeBuildInputs = [ ament-cmake python-cmake-module ];
  rosBuildExportDepends = [ lifecycle-msgs rcl rcl-action rcl-interfaces rcl-lifecycle rcl-logging-interface rcl-yaml-param-parser rmw rmw-implementation rosidl-runtime-c unique-identifier-msgs ];
  rosExecDepends = [ action-msgs ament-index-python builtin-interfaces lifecycle-msgs rcl rcl-action rcl-interfaces rcl-lifecycle rcl-logging-interface rcl-yaml-param-parser rmw rmw-implementation rosgraph-msgs rosidl-runtime-c rpyutils unique-identifier-msgs ];

  meta = {
    description = "Package containing the Python client.";
    license = with lib.licenses; [ asl20 ];
  };
}
