
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-cmake-gtest, ament-lint-auto, ament-lint-common, asio, asio-cmake-module, rclcpp, std-msgs, udp-msgs }:
buildRosPackage {
  pname = "ros-rolling-io-context";
  version = "1.2.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/transport_drivers-release/archive/release/rolling/io_context/1.2.0-4.tar.gz";
    name = "1.2.0-4.tar.gz";
    sha256 = "e8c5c667ae59737916f31f204373f2d0e6255c6db58d5825733b18fdbeb7a8f3";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto asio-cmake-module rclcpp std-msgs udp-msgs ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ asio ];
  nativeBuildInputs = [ ament-cmake-auto asio-cmake-module ];
  rosBuildExportDepends = [ rclcpp std-msgs udp-msgs ];
  rosExecDepends = [ rclcpp std-msgs udp-msgs ];

  meta = {
    description = "A library to write Synchronous and Asynchronous networking applications";
    license = with lib.licenses; [ asl20 ];
  };
}
