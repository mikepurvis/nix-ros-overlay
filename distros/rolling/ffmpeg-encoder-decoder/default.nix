
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-clang-format, ament-cmake-gtest, ament-cmake-ros, ament-lint-auto, ament-lint-common, cv-bridge, ffmpeg, ffmpeg-image-transport-msgs, opencv, pkg-config, rclcpp, ros-environment, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-rolling-ffmpeg-encoder-decoder";
  version = "3.0.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ffmpeg_encoder_decoder-release/archive/release/rolling/ffmpeg_encoder_decoder/3.0.1-2.tar.gz";
    name = "3.0.1-2.tar.gz";
    sha256 = "5287c8bac3726df688276badbcd9e53667ccdfb137e4136aed8549032c9502cd";
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
