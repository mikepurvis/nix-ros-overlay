
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, easynav-common, easynav-core, easynav-costmap-common, easynav-localizer, easynav-sensors, eigen, geometry-msgs, nav-msgs, pluginlib, rclcpp, rclcpp-lifecycle, std-srvs, tf2, tf2-geometry-msgs, tf2-ros }:
buildRosPackage {
  pname = "ros-jazzy-easynav-costmap-localizer";
  version = "0.4.0-r1";

  src = fetchurl {
    url = "https://github.com/EasyNavigation/easynav_plugins-release/archive/release/jazzy/easynav_costmap_localizer/0.4.0-1.tar.gz";
    name = "0.4.0-1.tar.gz";
    sha256 = "63b0c62fa202a10e424ac7b12968362b4b96a20265682cf051cb3fd6b692b27d";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake easynav-common easynav-core easynav-costmap-common easynav-localizer easynav-sensors geometry-msgs nav-msgs pluginlib tf2 tf2-geometry-msgs tf2-ros ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common rclcpp rclcpp-lifecycle std-srvs ];
  propagatedBuildInputs = [ eigen ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ easynav-common easynav-core easynav-costmap-common easynav-localizer easynav-sensors geometry-msgs nav-msgs pluginlib tf2 tf2-geometry-msgs tf2-ros ];

  meta = {
    description = "Easy Navigation: Costmap Localizer package.";
    license = with lib.licenses; [ asl20 ];
  };
}
