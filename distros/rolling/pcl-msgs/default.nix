
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-pcl-msgs";
  version = "1.0.0-r9";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/pcl_msgs-release/archive/release/rolling/pcl_msgs/1.0.0-9.tar.gz";
    name = "1.0.0-9.tar.gz";
    sha256 = "292fa3e7cda98e405aba3997a63e8045ef423c0b6a595d4c6ab9d528307a97ef";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rosidl-default-generators sensor-msgs std-msgs ];
  checkInputs = [ ament-lint-common ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ sensor-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime sensor-msgs std-msgs ];

  meta = {
    description = "Package containing PCL (Point Cloud Library)-related ROS messages.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
