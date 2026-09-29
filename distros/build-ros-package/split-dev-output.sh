# Moves the build-time half of a CMake-built ROS package (headers and CMake
# configs) into the dev output, so that the out output, which is all that
# runtime environments reference, no longer carries -dev paths of system
# libraries baked into include-dir and link-library lists.
#
# ament_cmake itself does most of this: buildRosPackage passes
# AMENT_CMAKE_CONFIG_INSTALL_PREFIX=$dev (ament/ament_cmake#641), so configs
# are installed to $dev/share/<pkg>/cmake and name $out absolutely. What is
# left here covers packages and templates that still assume a single prefix.
# Each rule records itself in $dev/nix-support/split-dev-fixups when it
# fires, so a build's report shows which upstream assumptions remain.

_splitDevFixup() {
    echo "split-dev-fixup: $1: $2"
    mkdir -p "$dev/nix-support"
    echo "$1 $2" >> "$dev/nix-support/split-dev-fixups"
}

_splitDevRel() {
    local p=${1/#$out/\$out}
    echo "${p/#$dev/\$dev}"
}

# Like moveToOutput, but merges into a directory that already exists, as when
# a package honours the absolute CMAKE_INSTALL_INCLUDEDIR for some headers but
# installs others to a hardcoded include/.
_mergeToDev() {
    [ -e "$out/$1" ] || return 0
    if [ -e "$dev/$1" ]; then
        cp -a --no-target-directory "$out/$1" "$dev/$1"
        rm -rf "${out:?}/$1"
    else
        moveToOutput "$1" "$dev"
    fi
    _movedToDev+=("$1")
    _splitDevFixup "moved:${2:-$1}" "$1"
}

# Rewrites a file in place with sed, recording the rule if anything changed.
_splitDevSed() {
    local rule=$1 f=$2; shift 2
    local before
    before=$(cksum < "$f")
    sed -i -E "$@" "$f"
    [ "$before" = "$(cksum < "$f")" ] || _splitDevFixup "$rule" "$(_splitDevRel "$f")"
}

splitDevOutput() {
    if [ -z "${dev:-}" ] || [ "$dev" = "$out" ]; then return 0; fi
    _movedToDev=()
    local f d

    # Headers installed to a literal include/ rather than
    # CMAKE_INSTALL_INCLUDEDIR, and configs of plain CMake packages, which
    # nixpkgs would move to dev anyway.
    _mergeToDev include
    _mergeToDev lib/cmake
    _mergeToDev lib/pkgconfig
    _mergeToDev share/pkgconfig

    # Configs that bypassed ament_package(): a hand-written install to
    # share/<pkg>/cmake, or somewhere else entirely, such as urdfdom_headers'
    # ${CMAKE_INSTALL_LIBDIR}/urdfdom_headers/cmake.
    while IFS= read -r -d '' d; do
        [ -n "$(find "$d" \( -name '*Config.cmake' -o -name '*-config.cmake' -o -name '*Export.cmake' -o -name '*-extras.cmake' \) -print -quit)" ] || continue
        _mergeToDev "${d#"$out"/}" config-outside-dev
    done < <(find "$out" -depth -type d \( -name cmake -o -name CMake \) -print0)

    # CMake helpers installed next to a config that is already in dev, with a
    # literal share/${PROJECT_NAME} rather than the config install dir:
    # install(DIRECTORY cmake DESTINATION share/${PROJECT_NAME}) in pluginlib,
    # rcl, rclcpp_components and many more, or rosidl_generator_c's
    # install(DIRECTORY cmake resource ...). They're copied verbatim, so moving
    # them after install is the same as installing them there.
    for d in "$out"/share/*/cmake; do
        [ -d "$d" ] && [ -d "$dev/share/$(basename "$(dirname "$d")")/cmake" ] || continue
        _mergeToDev "${d#"$out"/}" cmake-helpers
    done

    # A config that baked the absolute $out path of something that then moved.
    for d in "${_movedToDev[@]}"; do
        while IFS= read -r -d '' f; do
            _splitDevSed repoint "$f" -e "s#$out/$d([/\"; )]|\$)#$dev/$d\1#g"
        done < <(grep -rlZF "$out/$d" "$dev" --include='*.cmake' --include='*.pc' || true)
    done

    local cmakedir pkg entry
    for cmakedir in "$dev"/share/*/cmake; do
        [ -d "$cmakedir" ] || continue
        pkg=$(basename "$(dirname "$cmakedir")")

        # rosidl consumers find a dependency's .idl files, and generators
        # their templates, relative to ${pkg_DIR}; those live in out.
        if [ -d "$out/share/$pkg" ]; then
            for entry in "$out/share/$pkg"/*; do
                [ -e "$entry" ] || continue
                ln -s "$entry" "$dev/share/$pkg/$(basename "$entry")"
            done
        fi

        # Templates that find libraries, executables and Python modules as
        # ${pkg_DIR}/../../../lib: rosidl's generator and typesupport extras.
        while IFS= read -r -d '' f; do
            _splitDevSed relative-lib-walk "$f" \
                -e "s#\\\$\{$pkg""_DIR\}/\.\./\.\./\.\./(lib|bin)([/\"; )]|\$)#$out/\1\2#g" \
                -e "s#\\\$\{CMAKE_CURRENT_LIST_DIR\}/\.\./\.\./\.\./(lib|bin)([/\"; )]|\$)#$out/\1\2#g"
        done < <(find "$cmakedir" -type f -name '*.cmake' -print0)
    done

    # CMake's own install(EXPORT) files locate everything from _IMPORT_PREFIX:
    # $out when the export dir is absolute, as #641 makes it, or the file's own
    # location for an export a package installs itself. Either way only one of
    # lib/ and include/ is under it.
    while IFS= read -r -d '' f; do
        _splitDevSed import-prefix "$f" \
            -e "s#\\\$\{(_IMPORT_PREFIX|PACKAGE_PREFIX_DIR)\}/(lib|bin)([/\"; )]|\$)#$out/\2\3#g" \
            -e "s#\\\$\{(_IMPORT_PREFIX|PACKAGE_PREFIX_DIR)\}/include([/\"; )]|\$)#$dev/include\2#g"
    done < <(find "$dev" -type f -name '*.cmake' -exec grep -lZE '_IMPORT_PREFIX|PACKAGE_PREFIX_DIR' {} + || true)

    # pkg-config files moved to dev still say prefix=$out.
    for d in "$dev/lib/pkgconfig" "$dev/share/pkgconfig"; do
        [ -d "$d" ] || continue
        while IFS= read -r -d '' f; do
            _splitDevSed pc-includedir "$f" -e "s#^includedir=\\\$\{prefix\}/include#includedir=$dev/include#"
        done < <(find "$d" -name '*.pc' -print0)
    done

    # moveToOutput prunes emptied parents, which takes out itself with it for
    # a header-only package.
    mkdir -p "$out"

    # Anything left in out that names dev is a reference cycle; Nix would
    # only say which outputs are involved, so name the files.
    while IFS= read -r f; do
        _splitDevFixup leak "$(_splitDevRel "$f")"
    done < <(grep -rlF "$dev" "$out" || true)
}
