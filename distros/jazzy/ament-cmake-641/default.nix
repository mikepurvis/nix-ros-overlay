# ament/ament_cmake#641 (with #631, which it builds on) backported to jazzy:
# AMENT_CMAKE_CONFIG_INSTALL_PREFIX lets CMake config files be installed
# into the dev output, with generated files naming the install prefix
# absolutely. One patch per package, since each is released separately.
rosSuper:
builtins.listToAttrs (map (file: let
  pkg = builtins.replaceStrings [ "_" ".patch" ] [ "-" "" ] file;
in {
  name = pkg;
  value = rosSuper.${pkg}.overrideAttrs ({ patches ? [ ], ... }: {
    patches = patches ++ [ (./. + "/${file}") ];
  });
}) (builtins.filter (f: builtins.match ".*\\.patch" f != null)
  (builtins.attrNames (builtins.readDir ./.))))
