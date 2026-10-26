# Pending upstream changes

This branch carries upstream changes that haven't landed yet, so that it
always builds the current state of the dev/out output split. Background and
the plan for the upstream changes:
https://gist.github.com/mikepurvis/dc08a98959c4d499b2c83ad7f6e0ccbc

The split itself is switched on per distro by `splitDevOutputs` in
`distros/distro-overlay.nix` (jazzy and rolling, for now), or for one build with
`rosPackages.<distro>.overrideScope (_: _: { splitDevOutputs = true; })`. The
ROS patches below only apply where it is on.

Each one lives in a single file per layer, and comes out when its condition
below is met.

| Change | Upstream | Carried in | Drop when |
|---|---|---|---|
| vtk split into `out` and `dev` | [NixOS/nixpkgs#568868](https://github.com/NixOS/nixpkgs/pull/568868) | `pkgs/pending-upstream.nix` | nixpkgs is bumped past the merge. The override already turns itself off once `vtk` has a `dev` output. |
| pagmo2 split into `out` and `dev` | [NixOS/nixpkgs#569163](https://github.com/NixOS/nixpkgs/pull/569163) | `pkgs/pending-upstream.nix` | Same as vtk. |
| `AMENT_CMAKE_CONFIG_INSTALL_PREFIX` | [ament/ament_cmake#641](https://github.com/ament/ament_cmake/pull/641) | diff pinned in `distros/pending-upstream.nix`; applied by `distros/rolling/pending-upstream.nix`, and by `distros/jazzy/pending-upstream.nix` together with #631, which jazzy lacks | Rolling: a rolling release of ament_cmake contains it. Jazzy: a jazzy release contains #631 and #641, which needs a backport; otherwise it stays carried. When the PR moves, update the pinned head commit and hash in one place. Pinned for now to the `review-641` state on mikepurvis/ament_cmake, which the rosidl change below needs. |
| Generators and typesupports find a dependency's IDL with `rosidl_find_package_idl` | Merged 2026-10-26, unreleased: [ros2/rosidl#1013](https://github.com/ros2/rosidl/pull/1013), [ros2/rosidl_typesupport#176](https://github.com/ros2/rosidl_typesupport/pull/176), [ros2/rosidl_typesupport_fastrtps#169](https://github.com/ros2/rosidl_typesupport_fastrtps/pull/169), [ros2/rosidl_python#268](https://github.com/ros2/rosidl_python/pull/268), [ros2/rosidl_dds#66](https://github.com/ros2/rosidl_dds/pull/66); plus [ros2/rosidl#1006](https://github.com/ros2/rosidl/pull/1006), which the share-dir diff below is written on top of | merge commits pinned in `distros/pending-upstream.nix` (`rosidlDiffs`); applied by both `distros/{jazzy,rolling}/pending-upstream.nix`, which also add the `rosidl_cmake` dependency these PRs add to package.xml (`rosidlAddedDeps`) | Rolling: a rolling release of each repo contains them. Jazzy: they would need backports; until then they stay carried. |
| Interface packages export `<pkg>_DATADIR`; generators and typesupports find their own files with `ament_package_install_prefix` | Prototype, no PRs yet: `dev-out-share-dir` on mikepurvis/[rosidl](https://github.com/mikepurvis/rosidl/tree/dev-out-share-dir), [rosidl_typesupport](https://github.com/mikepurvis/rosidl_typesupport/tree/dev-out-share-dir), [rosidl_typesupport_fastrtps](https://github.com/mikepurvis/rosidl_typesupport_fastrtps/tree/dev-out-share-dir), [rosidl_python](https://github.com/mikepurvis/rosidl_python/tree/dev-out-share-dir), rebased onto rolling after the PRs above; rosidl_dds and rosidl_rust (rosidl_generator_rs, which also needs the IDL lookup) have no fork yet, so their diffs are in `distros/pending-upstream/` | diffs pinned in `distros/pending-upstream.nix`, after the merged ones | Each goes upstream after #641 lands, which they depend on. Once released, the fixup's share symlink can go. |

Upstream changes that are already merged, and need only a nixpkgs bump:
NixOS/nixpkgs#568869 (pcl) and #569009 (rtabmap).

## Covered by the fixup instead

`distros/build-ros-package/split-dev-output.sh` handles everything still
installed as if into one prefix: helper modules in `share/<pkg>/cmake`,
relative walks from a config to `lib/`, and exports anchored at their own
location. Each rule records itself in `$dev/nix-support/split-dev-fixups`
when it fires, so the fixup report shows what the upstream changes above remove.
