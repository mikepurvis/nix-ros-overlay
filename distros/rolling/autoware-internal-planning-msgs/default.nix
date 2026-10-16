
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-auto, ament-lint-auto, ament-lint-common, autoware-common-msgs, autoware-perception-msgs, autoware-planning-msgs, builtin-interfaces, geometry-msgs, rosidl-default-generators, rosidl-default-runtime, std-msgs, unique-identifier-msgs }:
buildRosPackage {
  pname = "ros-rolling-autoware-internal-planning-msgs";
  version = "1.12.1-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/autoware_internal_msgs-release/archive/release/rolling/autoware_internal_planning_msgs/1.12.1-2.tar.gz";
    name = "1.12.1-2.tar.gz";
    sha256 = "47593487c49524816f12df1a23a70a9ed8095be808c437984cb0f4d1b9b829f2";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-auto autoware-common-msgs autoware-perception-msgs autoware-planning-msgs builtin-interfaces geometry-msgs rosidl-default-generators std-msgs unique-identifier-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-auto ];
  rosBuildExportDepends = [ autoware-common-msgs autoware-perception-msgs autoware-planning-msgs builtin-interfaces geometry-msgs std-msgs unique-identifier-msgs ];
  rosExecDepends = [ autoware-common-msgs autoware-perception-msgs autoware-planning-msgs builtin-interfaces geometry-msgs rosidl-default-runtime std-msgs unique-identifier-msgs ];

  meta = {
    description = "The autoware_internal_planning_msgs package";
    license = with lib.licenses; [ asl20 ];
  };
}
