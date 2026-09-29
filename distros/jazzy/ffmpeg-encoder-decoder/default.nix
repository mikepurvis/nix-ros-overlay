
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-clang-format, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, cv-bridge, ffmpeg, ffmpeg-image-transport-msgs, opencv, pkg-config, rclcpp, ros-environment, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-ffmpeg-encoder-decoder";
  version = "3.0.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ffmpeg_encoder_decoder-release/archive/release/jazzy/ffmpeg_encoder_decoder/3.0.1-1.tar.gz";
    name = "3.0.1-1.tar.gz";
    sha256 = "174259a6dce7959240752e574491f8e5cb86787623d053017a7f993961e82d56";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-ros cv-bridge pkg-config rclcpp ros-environment sensor-msgs std-msgs ];
  checkInputs = [ ament-cmake-clang-format ament-cmake-gtest ament-lint-auto ament-lint-common ffmpeg-image-transport-msgs ];
  propagatedBuildInputs = [ ffmpeg opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake ament-cmake-ros pkg-config ros-environment ];
  rosBuildExportDepends = [ cv-bridge rclcpp sensor-msgs std-msgs ];
  rosExecDepends = [ cv-bridge rclcpp sensor-msgs std-msgs ];

  meta = {
    description = "ROS2 convenience wrapper around ffmpeg for encoding/decoding";
    license = with lib.licenses; [ asl20 ];
  };
}
