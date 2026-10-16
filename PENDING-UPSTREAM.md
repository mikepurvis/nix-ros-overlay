# Pending upstream changes

This branch carries upstream changes that haven't landed yet, so that it
always builds the current state of the dev/out output split. Background and
the plan for the upstream changes:
https://gist.github.com/mikepurvis/dc08a98959c4d499b2c83ad7f6e0ccbc

Each one lives in a single file per layer, and comes out when its condition
below is met.

| Change | Upstream | Carried in | Drop when |
|---|---|---|---|
| vtk split into `out` and `dev` | [NixOS/nixpkgs#568868](https://github.com/NixOS/nixpkgs/pull/568868) | `pkgs/pending-upstream.nix` | nixpkgs is bumped past the merge. The override already turns itself off once `vtk` has a `dev` output. |
| pagmo2 split into `out` and `dev` | [NixOS/nixpkgs#569163](https://github.com/NixOS/nixpkgs/pull/569163) | `pkgs/pending-upstream.nix` | Same as vtk. |
| `AMENT_CMAKE_CONFIG_INSTALL_PREFIX` (with #631, which it builds on) | [ament/ament_cmake#641](https://github.com/ament/ament_cmake/pull/641) | `distros/jazzy/pending-upstream.nix`, patching the four packages whose output it changes | A jazzy release of ament_cmake contains both. If #641 lands only in rolling, it stays carried for jazzy. When the PR moves, update the pinned head commit and hash. |

Upstream changes that are already merged, and need only a nixpkgs bump:
NixOS/nixpkgs#568869 (pcl) and #569009 (rtabmap).

## Covered by the fixup instead

`distros/build-ros-package/split-dev-output.sh` handles everything still
installed as if into one prefix: helper modules in `share/<pkg>/cmake`,
relative walks from a config to `lib/`, and exports anchored at their own
location. Each rule records itself in `$dev/nix-support/split-dev-fixups`
when it fires, so the fixup report shows what the upstream changes above (and
the rosidl ones still to come) remove.
