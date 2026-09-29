
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, backward-ros, controller-interface, controller-manager, generate-parameter-library, hardware-interface, hardware-interface-testing, pluginlib, rclcpp, rclcpp-lifecycle, ros2-control-cmake, ros2-control-test-assets, rosidl-default-runtime, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-clearpath-bms-broadcaster";
  version = "2.9.16-r1";

  src = fetchurl {
    url = "https://github.com/clearpath-gbp/clearpath_common-release/archive/release/jazzy/clearpath_bms_broadcaster/2.9.16-1.tar.gz";
    name = "2.9.16-1.tar.gz";
    sha256 = "422e07278442483db21ef968411d532aebefffc0b96a92931a078f25e567ec55";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake backward-ros controller-interface generate-parameter-library hardware-interface pluginlib rclcpp rclcpp-lifecycle ros2-control-cmake sensor-msgs ];
  checkInputs = [ ament-cmake-gmock controller-manager hardware-interface-testing ros2-control-test-assets ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ backward-ros controller-interface hardware-interface pluginlib rclcpp rclcpp-lifecycle sensor-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "ros2_control battery state broadcaster controller";
    license = with lib.licenses; [ asl20 ];
  };
}
