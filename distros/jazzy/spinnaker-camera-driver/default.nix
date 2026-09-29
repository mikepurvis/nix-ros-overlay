
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-clang-format, ament-cmake-ros, ament-lint-auto, ament-lint-common, camera-info-manager, curl, diagnostic-updater, dpkg, ffmpeg, flir-camera-msgs, image-transport, libusb1, llvmPackages, python3Packages, rclcpp, rclcpp-components, ros-environment, sensor-msgs, std-msgs, yaml-cpp }:
buildRosPackage {
  pname = "ros-jazzy-spinnaker-camera-driver";
  version = "3.0.5-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/flir_camera_driver-release/archive/release/jazzy/spinnaker_camera_driver/3.0.5-1.tar.gz";
    name = "3.0.5-1.tar.gz";
    sha256 = "3d34a97681af84cd1cbe4d676be2070e8879f5970948e907c35a9c16b1f2ebe4";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-ros camera-info-manager curl diagnostic-updater dpkg flir-camera-msgs image-transport python3Packages.distro rclcpp rclcpp-components ros-environment sensor-msgs std-msgs ];
  checkInputs = [ ament-cmake-clang-format ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ ffmpeg libusb1 llvmPackages.openmp yaml-cpp ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros ros-environment ];
  rosBuildExportDepends = [ camera-info-manager diagnostic-updater flir-camera-msgs image-transport rclcpp rclcpp-components sensor-msgs std-msgs ];
  rosExecDepends = [ camera-info-manager diagnostic-updater flir-camera-msgs image-transport rclcpp rclcpp-components sensor-msgs std-msgs ];

  meta = {
    description = "ROS2 driver for flir spinnaker sdk";
    license = with lib.licenses; [ asl20 bsdOriginal ];
  };
}
