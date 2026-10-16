
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-off-highway-premium-radar-sample-msgs";
  version = "1.3.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/off_highway_sensor_drivers-release/archive/release/rolling/off_highway_premium_radar_sample_msgs/1.3.0-2.tar.gz";
    name = "1.3.0-2.tar.gz";
    sha256 = "42c958cc91f9f51f950148f4944e40e3a9757ea057b6f7f838c7763fd65f216b";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake builtin-interfaces geometry-msgs rosidl-default-generators std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs std-msgs ];
  rosExecDepends = [ builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs ];

  meta = {
    description = "The off_highway_premium_radar_sample_msgs package";
    license = with lib.licenses; [ asl20 ];
  };
}
