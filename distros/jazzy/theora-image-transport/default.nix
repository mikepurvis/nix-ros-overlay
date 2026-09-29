
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-auto, ament-lint-common, cv-bridge, image-transport, libogg, libtheora, opencv, pkg-config, pluginlib, rclcpp, rcutils, rosidl-default-generators, rosidl-default-runtime, sensor-msgs, std-msgs }:
buildRosPackage {
  pname = "ros-jazzy-theora-image-transport";
  version = "4.0.7-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/image_transport_plugins-release/archive/release/jazzy/theora_image_transport/4.0.7-1.tar.gz";
    name = "4.0.7-1.tar.gz";
    sha256 = "6eab3a97c0a71940b9e20b764afda38e6b5841a41af57d77859deeb32e53f6f4";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake cv-bridge image-transport pkg-config pluginlib rclcpp rcutils rosidl-default-generators sensor-msgs std-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ libogg libtheora opencv opencv.cxxdev ];
  nativeBuildInputs = [ ament-cmake pkg-config rosidl-default-generators ];
  rosBuildExportDepends = [ cv-bridge image-transport pluginlib rclcpp rcutils sensor-msgs std-msgs ];
  rosExecDepends = [ rosidl-default-runtime ];

  meta = {
    description = "Theora_image_transport provides a plugin to image_transport for
    transparently sending an image stream encoded with the Theora codec.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
