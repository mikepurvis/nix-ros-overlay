
# Copyright 2026 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-ros, ament-lint-auto, ament-lint-common, rqt-image-overlay-layer, vision-msgs }:
buildRosPackage {
  pname = "ros-jazzy-vision-msgs-layers";
  version = "0.2.0-r4";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/vision_msgs_layers-release/archive/release/jazzy/vision_msgs_layers/0.2.0-4.tar.gz";
    name = "0.2.0-4.tar.gz";
    sha256 = "b803befe3f6be9b9ec0eb80968ba3cd3fb93040b9358a5d2430ba3f021f72b02";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake-ros rqt-image-overlay-layer vision-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  nativeBuildInputs = [ ament-cmake-ros ];
  rosBuildExportDepends = [ rqt-image-overlay-layer vision-msgs ];
  rosExecDepends = [ rqt-image-overlay-layer vision-msgs ];

  meta = {
    description = "Collection of RQt Image Overlay Plugins for Vision Msgs";
    license = with lib.licenses; [ asl20 ];
  };
}
