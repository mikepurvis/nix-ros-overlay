# Upstream ROS changes the dev/out split relies on that rolling hasn't
# released yet. See ../pending-upstream.nix and PENDING-UPSTREAM.md.
self: rosSelf: rosSuper:
let
  upstream = import ../pending-upstream.nix self rosSelf rosSuper;
in
upstream.apply {
  diffs = [ upstream.diffs.ament_cmake_641 ];
  dirs = upstream.amentCmake641Dirs;
}
