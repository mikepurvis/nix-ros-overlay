
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, rclcpp, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-dummy-sensors";
  version = "0.33.11-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/demos-release/archive/release/jazzy/dummy_sensors/0.33.11-1.tar.gz";
    name = "0.33.11-1.tar.gz";
    sha256 = "f355c531177b5b087d522d9d7ba9b49884568b9ba79daea6bce654bb5e10d843";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake rclcpp sensor-msgs ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ rclcpp sensor-msgs ];
  rosExecDepends = [ rclcpp sensor-msgs ];

  meta = {
    description = "dummy sensor nodes";
    license = with lib.licenses; [ asl20 ];
  };
}
