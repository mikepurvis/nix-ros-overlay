
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, class-loader, eigen, generate-parameter-library, launch-param-builder, moveit-common, moveit-configs-utils, moveit-core, moveit-msgs, moveit-resources-fanuc-description, moveit-resources-fanuc-moveit-config, moveit-resources-panda-description, moveit-resources-panda-moveit-config, moveit-ros-planning, orocos-kdl-vendor, pluginlib, python3Packages, ros-testing, rsl, tf2, tf2-kdl, urdfdom }:
buildRosPackage {
  pname = "ros-rolling-moveit-kinematics";
  version = "2.15.2-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/moveit2-release/archive/release/rolling/moveit_kinematics/2.15.2-1.tar.gz";
    name = "2.15.2-1.tar.gz";
    sha256 = "f149df8190fcdde0f2bbff10d0364b4e36120d36cef3246186938f47f866f225";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake class-loader generate-parameter-library moveit-common moveit-core moveit-msgs moveit-ros-planning orocos-kdl-vendor pluginlib rsl tf2 tf2-kdl ];
  checkInputs = [ ament-cmake-gtest launch-param-builder moveit-configs-utils moveit-resources-fanuc-description moveit-resources-fanuc-moveit-config moveit-resources-panda-description moveit-resources-panda-moveit-config ros-testing ];
  propagatedBuildInputs = [ eigen python3Packages.lxml ];
  nativeBuildInputs = [ ament-cmake ];
  rosBuildExportDepends = [ class-loader generate-parameter-library moveit-common moveit-core moveit-msgs moveit-ros-planning orocos-kdl-vendor pluginlib rsl tf2 tf2-kdl ];
  rosExecDepends = [ class-loader generate-parameter-library moveit-common moveit-core moveit-msgs moveit-ros-planning orocos-kdl-vendor pluginlib rsl tf2 tf2-kdl urdfdom ];

  meta = {
    description = "Package for all inverse kinematics solvers in MoveIt";
    license = with lib.licenses; [ bsd3 ];
  };
}
