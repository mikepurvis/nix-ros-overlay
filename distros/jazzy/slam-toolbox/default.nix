
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-cpplint, ament-cmake-flake8, ament-cmake-gtest, ament-cmake-uncrustify, ament-lint-auto, bond, bondcpp, boost, builtin-interfaces, ceres-solver, eigen, interactive-markers, launch, launch-testing, liblapack, lifecycle-msgs, message-filters, nav-msgs, onetbb, pluginlib, qt5, rclcpp, rclcpp-lifecycle, rosidl-default-generators, rviz-common, rviz-default-plugins, rviz-ogre-vendor, rviz-rendering, sensor-msgs, std-msgs, std-srvs, suitesparse, tf2, tf2-geometry-msgs, tf2-ros, tf2-sensor-msgs, visualization-msgs }:
buildRosPackage {
  pname = "ros-jazzy-slam-toolbox";
  version = "2.8.5-r1";

  src = fetchurl {
    url = "https://github.com/SteveMacenski/slam_toolbox-release/archive/release/jazzy/slam_toolbox/2.8.5-1.tar.gz";
    name = "2.8.5-1.tar.gz";
    sha256 = "15269a30c01fa00374896c747f34ec44bc4b375dabca1da2166bc8a350a1f263";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake bond bondcpp builtin-interfaces interactive-markers lifecycle-msgs message-filters nav-msgs pluginlib rclcpp rclcpp-lifecycle rosidl-default-generators rviz-common rviz-default-plugins rviz-ogre-vendor rviz-rendering sensor-msgs std-msgs std-srvs tf2 tf2-geometry-msgs tf2-ros tf2-sensor-msgs visualization-msgs ];
  checkInputs = [ ament-cmake-cpplint ament-cmake-flake8 ament-cmake-gtest ament-cmake-uncrustify ament-lint-auto launch launch-testing ];
  propagatedBuildInputs = [ boost ceres-solver eigen liblapack onetbb qt5.qtbase suitesparse ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ bond bondcpp builtin-interfaces interactive-markers lifecycle-msgs message-filters nav-msgs pluginlib rclcpp rclcpp-lifecycle rosidl-default-generators rviz-common rviz-default-plugins rviz-ogre-vendor rviz-rendering sensor-msgs std-msgs std-srvs tf2 tf2-geometry-msgs tf2-ros tf2-sensor-msgs visualization-msgs ];

  meta = {
    description = "This package provides a sped up improved slam karto with updated SDK and visualization and modification toolsets";
    license = with lib.licenses; [ "LGPL" ];
  };
}
