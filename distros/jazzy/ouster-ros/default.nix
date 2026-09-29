
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, class-loader, curl, cv-bridge, eigen, geometry-msgs, gtest, jsoncpp, launch, launch-ros, libtins, libzip, ouster-sensor-msgs, pcl, pcl-conversions, rclcpp, rclcpp-components, rclcpp-lifecycle, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, spdlog, std-msgs, std-srvs, tf2-eigen, tf2-ros }:
buildRosPackage {
  pname = "ros-jazzy-ouster-ros";
  version = "0.15.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ouster-ros-release/archive/release/jazzy/ouster_ros/0.15.1-1.tar.gz";
    name = "0.15.1-1.tar.gz";
    sha256 = "825239b4fdaede6a8970e381b177aff9a320aee4d7aeae2d45bda0d57349795d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake class-loader cv-bridge eigen geometry-msgs libtins libzip ouster-sensor-msgs pcl pcl-conversions rclcpp rclcpp-components rclcpp-lifecycle rosidl-default-generators sensor-msgs std-msgs std-srvs tf2-eigen tf2-ros ];
  checkInputs = [ ament-cmake-gtest gtest ];
  propagatedBuildInputs = [ curl jsoncpp spdlog ];
  nativeBuildInputs = [ ament-cmake rosidl-default-generators ];
  rosBuildExportDepends = [ class-loader cv-bridge geometry-msgs ouster-sensor-msgs pcl-conversions rclcpp rclcpp-components rclcpp-lifecycle sensor-msgs std-msgs std-srvs tf2-ros ];
  rosExecDepends = [ class-loader cv-bridge geometry-msgs launch launch-ros ouster-sensor-msgs pcl-conversions rclcpp rclcpp-components rclcpp-lifecycle rosidl-default-runtime sensor-msgs std-msgs std-srvs tf2-ros ];

  meta = {
    description = "Ouster ROS2 driver";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
