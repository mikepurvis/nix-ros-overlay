
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, control-msgs, controller-manager, generate-parameter-library, geometry-msgs, joint-state-broadcaster, joint-trajectory-controller, joy, launch-param-builder, moveit-common, moveit-configs-utils, moveit-core, moveit-msgs, moveit-resources-panda-moveit-config, moveit-ros-planning, moveit-ros-planning-interface, moveit-ros-visualization, pluginlib, realtime-tools, robot-state-publisher, ros-testing, sensor-msgs, std-msgs, std-srvs, tf2-eigen, tf2-ros, trajectory-msgs }:
buildRosPackage {
  pname = "ros-rolling-moveit-servo";
  version = "2.15.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/rolling/moveit_servo/2.15.2-1.tar.gz";
    name = "2.15.2-1.tar.gz";
    sha256 = "a69298c89787441e934e67dd243f34053b1b0bb5c1099943c0dc2ed89bc2c161";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake control-msgs generate-parameter-library geometry-msgs moveit-common moveit-core moveit-msgs moveit-ros-planning moveit-ros-planning-interface pluginlib realtime-tools sensor-msgs std-msgs std-srvs tf2-eigen trajectory-msgs ];
  checkInputs = [ ament-cmake-gtest moveit-resources-panda-moveit-config ros-testing ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ control-msgs generate-parameter-library geometry-msgs moveit-common moveit-core moveit-msgs moveit-ros-planning moveit-ros-planning-interface pluginlib realtime-tools sensor-msgs std-msgs std-srvs tf2-eigen trajectory-msgs ];
  rosExecDepends = [ control-msgs controller-manager generate-parameter-library geometry-msgs joint-state-broadcaster joint-trajectory-controller joy launch-param-builder moveit-common moveit-configs-utils moveit-core moveit-msgs moveit-ros-planning moveit-ros-planning-interface moveit-ros-visualization pluginlib realtime-tools robot-state-publisher sensor-msgs std-msgs std-srvs tf2-eigen tf2-ros trajectory-msgs ];

  meta = {
    description = "Provides real-time manipulator Cartesian and joint servoing.";
    license = with lib.licenses; [ bsd3 ];
  };
}
