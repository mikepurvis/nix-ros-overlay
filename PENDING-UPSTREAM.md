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
| `AMENT_CMAKE_CONFIG_INSTALL_PREFIX` | [ament/ament_cmake#641](https://github.com/ament/ament_cmake/pull/641) | diff pinned in `distros/pending-upstream.nix`; applied by `distros/rolling/pending-upstream.nix`, and by `distros/jazzy/pending-upstream.nix` together with #631, which jazzy lacks | Rolling: a rolling release of ament_cmake contains it. Jazzy: a jazzy release contains #631 and #641, which needs a backport; otherwise it stays carried. When the PR moves, update the pinned head commit and hash in one place. |

Upstream changes that are already merged, and need only a nixpkgs bump:
NixOS/nixpkgs#568869 (pcl) and #569009 (rtabmap).

## Covered by the fixup instead

`distros/build-ros-package/split-dev-output.sh` handles everything still
installed as if into one prefix: helper modules in `share/<pkg>/cmake`,
relative walks from a config to `lib/`, and exports anchored at their own
location. Each rule records itself in `$dev/nix-support/split-dev-fixups`
when it fires, so the fixup report shows what the upstream changes above (and
the rosidl ones still to come) remove.
