
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, ros-environment, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-delphi-mrr-msgs";
  version = "4.0.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/astuff_sensor_msgs-release/archive/release/rolling/delphi_mrr_msgs/4.0.0-4.tar.gz";
    name = "4.0.0-4.tar.gz";
    sha256 = "68a2e2ec2aaa2649b190aba6d7444d3060cab2c4340ffd229d600801c3670100";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces ros-environment rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ builtin-interfaces std-msgs ];
  rosExecDepends = [ builtin-interfaces rosidl-default-runtime std-msgs ];

  meta = {
    description = "Message definitions for the Delphi MRR";
    license = with lib.licenses; [ mit ];
  };
}
