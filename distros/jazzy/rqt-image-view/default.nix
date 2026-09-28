
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, cv-bridge, geometry-msgs, image-transport, qt-gui-cpp, qt5, rclcpp, rqt-gui, rqt-gui-cpp, sensor-msgs }:
buildRosPackage {
  pname = "ros-jazzy-rqt-image-view";
  version = "1.3.0-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rqt_image_view-release/archive/release/jazzy/rqt_image_view/1.3.0-2.tar.gz";
    name = "1.3.0-2.tar.gz";
    sha256 = "88ecbfca915c45e82e6091fcfe3da03eaed9402c02adb082ef4c1265c3b9b4c9";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake cv-bridge geometry-msgs image-transport qt-gui-cpp qt5.qtbase rqt-gui rqt-gui-cpp sensor-msgs ];
  propagatedBuildInputs = [ rclcpp ];
  nativeBuildInputs = [ ament-cmake ];
  rosExecDepends = [ cv-bridge geometry-msgs image-transport qt-gui-cpp rqt-gui rqt-gui-cpp sensor-msgs ];

  meta = {
    description = "rqt_image_view provides a GUI plugin for displaying images using image_transport.";
    license = with lib.licenses; [ bsdOriginal ];
  };
}
