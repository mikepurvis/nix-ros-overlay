
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, action-msgs, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-smacc2-msgs";
  version = "3.1.0-r2";

  src = fetchurl {
    url = "https://github.com/robosoft-ai/SMACC2-release/archive/release/jazzy/smacc2_msgs/3.1.0-2.tar.gz";
    name = "3.1.0-2.tar.gz";
    sha256 = "0ccfc046d539fdb9ccb36eb0a660df12a531abd50fc3b964ae5446b1d66bec2c";
  };

  buildType = "ament_cmake";
  buildInputs = [ action-msgs ament-cmake builtin-interfaces rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ action-msgs builtin-interfaces std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "Messages and services used in smacc2.";
    license = with lib.licenses; [ asl20 ];
  };
}
