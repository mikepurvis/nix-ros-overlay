
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-python, builtin-interfaces, geometry-msgs, interactive-markers, qt-gui-py-common, rclpy, rosidl-default-generators, rosidl-default-runtime, rqt-gui, rqt-gui-py, std-msgs, tf-transformations, tf2-ros, visualization-msgs }:
buildRosPackage {
  pname = "ros-jazzy-frame-editor";
  version = "2.0.2-r5";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rqt_frame_editor_plugin-release/archive/release/jazzy/frame_editor/2.0.2-5.tar.gz";
    name = "2.0.2-5.tar.gz";
    sha256 = "174f3172794766152b2caee5e26dc60f343c97c63925a1256abb60a051c76fa3";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ament-cmake-python builtin-interfaces geometry-msgs interactive-markers rclpy rosidl-default-generators rqt-gui rqt-gui-py std-msgs tf-transformations tf2-ros visualization-msgs ];
  nativeBuildInputs = [ ament-cmake ament-cmake-python rosidl-default-generators ];
  rosBuildExportDepends = [ builtin-interfaces geometry-msgs interactive-markers rclpy rqt-gui rqt-gui-py std-msgs tf-transformations tf2-ros visualization-msgs ];
  rosExecDepends = [ qt-gui-py-common rosidl-default-runtime ];

  meta = {
    description = "The frame_editor package";
    license = with lib.licenses; [ mit ];
  };
}
