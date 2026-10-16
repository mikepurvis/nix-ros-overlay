
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-cmake-pytest, ament-cmake-python, ament-index-cpp, ament-index-python, backward-ros, control-toolbox, controller-manager, eigen, fmt, geometry-msgs, git, glfw3, hardware-interface, mujoco-ros2-control-msgs, mujoco-ros2-control-plugins, mujoco-vendor, nav-msgs, pluginlib, python3, python3Packages, rclcpp, rclcpp-lifecycle, realtime-tools, ros2-control-cmake, ros2pkg, rosgraph-msgs, sensor-msgs, std-msgs, tinyxml-2, transmission-interface, urdfdom-py }:
buildRosPackage {
  pname = "ros-rolling-mujoco-ros2-control";
  version = "0.1.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mujoco_ros2_control-release/archive/release/rolling/mujoco_ros2_control/0.1.2-1.tar.gz";
    name = "0.1.2-1.tar.gz";
    sha256 = "c236dd58516a2178274e68a46943e4b2eadc772cc11a8e4f3dba1ec4db813d98";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-python ament-index-cpp backward-ros control-toolbox controller-manager geometry-msgs git hardware-interface mujoco-ros2-control-msgs mujoco-ros2-control-plugins mujoco-vendor nav-msgs pluginlib rclcpp rclcpp-lifecycle realtime-tools ros2-control-cmake ros2pkg rosgraph-msgs sensor-msgs std-msgs transmission-interface ];
  checkInputs = [ ament-cmake-gtest ament-cmake-pytest ];
  propagatedBuildInputs = [ eigen fmt glfw3 python3 python3Packages.importlib-resources python3Packages.numpy python3Packages.pip python3Packages.pykdl tinyxml-2 ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python git ];
  rosBuildExportDepends = [ ament-index-cpp backward-ros control-toolbox controller-manager geometry-msgs hardware-interface mujoco-ros2-control-msgs mujoco-ros2-control-plugins mujoco-vendor nav-msgs pluginlib rclcpp rclcpp-lifecycle realtime-tools ros2pkg rosgraph-msgs sensor-msgs std-msgs transmission-interface ];
  rosExecDepends = [ ament-index-cpp ament-index-python backward-ros control-toolbox controller-manager geometry-msgs hardware-interface mujoco-ros2-control-msgs mujoco-ros2-control-plugins mujoco-vendor nav-msgs pluginlib rclcpp rclcpp-lifecycle realtime-tools ros2pkg rosgraph-msgs sensor-msgs std-msgs transmission-interface urdfdom-py ];

  meta = {
    description = "ros2_control wrapper for the MuJoCo Simulate application";
    license = with lib.licenses; [ asl20 ];
  };
}
