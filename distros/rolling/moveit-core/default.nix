
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-cmake-google-benchmark, ament-cmake-gtest, ament-index-cpp, angles, assimp, boost, bullet, common-interfaces, eigen, eigen-stl-containers, eigen3-cmake-module, fcl, generate-parameter-library, geometric-shapes, geometry-msgs, google-benchmark-vendor, kdl-parser, launch-testing-ament-cmake, moveit-common, moveit-msgs, moveit-resources-panda-moveit-config, moveit-resources-pr2-description, octomap, octomap-msgs, orocos-kdl-vendor, osqp-vendor, pkg-config, pluginlib, random-numbers, rcl-interfaces, rclcpp, rclpy, rsl, ruckig, sensor-msgs, shape-msgs, srdfdom, std-msgs, tf2, tf2-eigen, tf2-geometry-msgs, tf2-kdl, trajectory-msgs, urdf, urdfdom, urdfdom-headers, visualization-msgs }:
buildRosPackage {
  pname = "ros-rolling-moveit-core";
  version = "2.15.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/rolling/moveit_core/2.15.2-1.tar.gz";
    name = "2.15.2-1.tar.gz";
    sha256 = "45af505335f180ca9045aa3c804af55894fbfb230008315c28344a4cb22a3f03";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake angles common-interfaces eigen-stl-containers eigen3-cmake-module generate-parameter-library geometric-shapes geometry-msgs google-benchmark-vendor kdl-parser moveit-common moveit-msgs octomap-msgs osqp-vendor pkg-config pluginlib random-numbers rclcpp rsl ruckig sensor-msgs shape-msgs srdfdom std-msgs tf2 tf2-eigen tf2-geometry-msgs tf2-kdl trajectory-msgs urdf urdfdom urdfdom-headers visualization-msgs ];
  checkInputs = [ ament-cmake-gmock ament-cmake-google-benchmark ament-cmake-gtest ament-index-cpp launch-testing-ament-cmake moveit-resources-panda-moveit-config moveit-resources-pr2-description orocos-kdl-vendor rcl-interfaces rclpy ];
  propagatedBuildInputs = [ assimp boost bullet eigen fcl octomap ];
  nativeBuildInputs = [ ament-cmake eigen3-cmake-module pkg-config ];
  rosBuildExportDepends = [ angles common-interfaces eigen-stl-containers eigen3-cmake-module generate-parameter-library geometric-shapes geometry-msgs google-benchmark-vendor kdl-parser moveit-common moveit-msgs octomap-msgs osqp-vendor pluginlib random-numbers rclcpp rsl ruckig sensor-msgs shape-msgs srdfdom std-msgs tf2 tf2-eigen tf2-geometry-msgs tf2-kdl trajectory-msgs urdf urdfdom urdfdom-headers visualization-msgs ];
  rosExecDepends = [ angles common-interfaces eigen-stl-containers generate-parameter-library geometric-shapes geometry-msgs google-benchmark-vendor kdl-parser moveit-common moveit-msgs octomap-msgs osqp-vendor pluginlib random-numbers rclcpp rsl ruckig sensor-msgs shape-msgs srdfdom std-msgs tf2 tf2-eigen tf2-geometry-msgs tf2-kdl trajectory-msgs urdf urdfdom urdfdom-headers visualization-msgs ];

  meta = {
    description = "Core libraries used by MoveIt";
    license = with lib.licenses; [ bsd3 ];
  };
}
