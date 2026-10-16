# Upstream ROS changes the dev/out split relies on that jazzy hasn't
# released. #641 targets rolling and builds on #631, which jazzy lacks, so
# both are applied. See ../pending-upstream.nix and PENDING-UPSTREAM.md.
self: rosSelf: rosSuper:
let
  upstream = import ../pending-upstream.nix self rosSelf rosSuper;
in
upstream.apply {
  diffs = [ upstream.diffs.ament_cmake_631 upstream.diffs.ament_cmake_641 ];
  dirs = upstream.amentCmake641Dirs;
} // upstream.apply {
  diffs = [ upstream.diffs.rosidl_share_dir ];
  dirs = upstream.rosidlShareDirDirs;
}
