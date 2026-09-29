
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-cmake-pytest, ament-lint-auto, ament-lint-common, geometry-msgs, launch, launch-ros, launch-testing, lcov, nav-msgs, nav2-amcl, nav2-behavior-tree, nav2-bringup, nav2-common, nav2-lifecycle-manager, nav2-map-server, nav2-minimal-tb3-sim, nav2-msgs, nav2-navfn-planner, nav2-planner, nav2-util, navigation2, python3Packages, rclcpp, rclpy, robot-state-publisher, std-msgs, tf2-geometry-msgs, visualization-msgs }:
buildRosPackage {
  pname = "ros-jazzy-nav2-system-tests";
  version = "1.3.13-r1";

  src = fetchurl {
    url = "https://github.com/SteveMacenski/navigation2-release/archive/release/jazzy/nav2_system_tests/1.3.13-1.tar.gz";
    name = "1.3.13-1.tar.gz";
    sha256 = "494e5e2a3e07e43cf80f25c05f17eb548e4d637019e8d2dcaa34a8228364bc01";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake geometry-msgs launch-ros launch-testing nav-msgs nav2-amcl nav2-behavior-tree nav2-common nav2-lifecycle-manager nav2-map-server nav2-minimal-tb3-sim nav2-msgs nav2-navfn-planner nav2-planner nav2-util rclcpp rclpy std-msgs tf2-geometry-msgs visualization-msgs ];
  checkInputs = [ ament-cmake-gtest ament-cmake-pytest ament-lint-auto ament-lint-common launch python3Packages.pyzmq ];
  propagatedBuildInputs = [ lcov ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ geometry-msgs launch-ros launch-testing nav-msgs nav2-amcl nav2-behavior-tree nav2-lifecycle-manager nav2-map-server nav2-minimal-tb3-sim nav2-msgs nav2-navfn-planner nav2-planner nav2-util rclcpp rclpy std-msgs tf2-geometry-msgs visualization-msgs ];
  rosExecDepends = [ nav2-bringup navigation2 robot-state-publisher ];

  meta = {
    description = "A sets of system-level tests for Nav2 usually involving full robot simulation";
    license = with lib.licenses; [ asl20 ];
  };
}
