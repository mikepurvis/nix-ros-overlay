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
    local f d

    # Headers installed to a literal include/ rather than
    # CMAKE_INSTALL_INCLUDEDIR, and configs of plain CMake packages, which
    # nixpkgs would move to dev anyway.
    _mergeToDev include
    _mergeToDev lib/cmake
    _mergeToDev lib/pkgconfig
    _mergeToDev lib64/pkgconfig
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

    # A config that baked an absolute $out path which now only exists in dev:
    # something that moved, or a parent of it, such as sdformat_vendor adding
    # $out/share/extra_cmake to CMAKE_PREFIX_PATH for a config beneath it.
    local p
    while IFS= read -r p; do
        [ ! -e "$out/$p" ] && [ -e "$dev/$p" ] || continue
        while IFS= read -r -d '' f; do
            _splitDevSed repoint "$f" -e "s#$out/$p([/\"; )]|\$)#$dev/$p\1#g"
        done < <(grep -rlZF "$out/$p" "$dev" --include='*.cmake' --include='*.pc' || true)
    done < <(grep -rhoE "$out/[^\"; )\$]+" "$dev" --include='*.cmake' --include='*.pc' 2>/dev/null \
        | sed "s#^$out/##; s#/*\$##" | sort -u | awk '{ print length, $0 }' | sort -rn | cut -d' ' -f2-)

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

    done

    # Configs and extras that find libraries, executables and data by walking
    # from their own directory back up to the prefix, which is now dev: the
    # ${pkg_DIR}/../../../lib in rosidl's generator and typesupport extras, or
    # urdfdom's "${urdfdom_DIR}/../../..//lib". The walk has to go exactly as
    # many levels up as the directory sits below dev.
    local cfgdir rel depth names name n aliases
    while IFS= read -r cfgdir; do
        rel=${cfgdir#"$dev"/}
        depth=$(( $(tr -cd / <<< "$rel" | wc -c) + 1 ))
        names=$(find "$cfgdir" -maxdepth 1 \( -name '*Config.cmake' -o -name '*-config.cmake' \) -printf '%f\n' \
            | sed -E 's/(-config|Config)\.cmake$//' | sort -u | paste -sd'|')
        [ -n "$names" ] || continue
        local up=""
        for ((n = 0; n < depth; n++)); do up="$up/\\.\\."; done
        while IFS= read -r -d '' f; do
            _splitDevSed relative-prefix-walk "$f" \
                -e "s#\\\$\{(($names)_DIR|CMAKE_CURRENT_LIST_DIR)\}$up/+(lib|lib64|bin|share)([/\"; )]|\$)#$out/\3\4#g"
            # The same walk kept in a variable and used later, as gz-msgs does
            # with set(gz-msgs10_INSTALL_PATH "${gz-msgs10_DIR}/../../../").
            aliases=$(grep -oE "set\\(\\s*[A-Za-z0-9_-]+\\s+\"?\\\$\\{(($names)_DIR|CMAKE_CURRENT_LIST_DIR)\\}$up/?\"?\\s*\\)" "$f" \
                | sed -E 's/set\(\s*([A-Za-z0-9_-]+).*/\1/' | paste -sd'|' || true)
            [ -n "$aliases" ] || continue
            _splitDevSed relative-prefix-alias "$f" \
                -e "s#\\\$\{($aliases)\}/+(lib|lib64|bin|share)([/\"; )]|\$)#$out/\2\3#g" \
                -e "s#\\\$\{($aliases)\}/+include([/\"; )]|\$)#$dev/include\2#g"
        done < <(find "$cfgdir" -maxdepth 1 -type f -name '*.cmake' -print0)
    done < <(find "$dev" -type f \( -name '*Config.cmake' -o -name '*-config.cmake' \) -printf '%h\n' | sort -u)

    # CMake's own install(EXPORT) files and configure_package_config_file()
    # configs locate everything from _IMPORT_PREFIX or PACKAGE_PREFIX_DIR,
    # sometimes through an alias (OGRE's set(OGRE_PREFIX_DIR
    # "${PACKAGE_PREFIX_DIR}")). With #641 the export dir is absolute and CMake
    # sets _IMPORT_PREFIX to $out, so only a literal include/ destination
    # (headers since moved to dev) needs fixing. A config or export a package
    # installs itself computes its prefix from the file's location, now dev,
    # so lib/, bin/ and share/ are pointed back at out as well.
    local exportdir vars
    while IFS= read -r exportdir; do
        local libs=1
        grep -qsF "set(_IMPORT_PREFIX \"$out\")" "$exportdir"/*.cmake && libs=
        while IFS= read -r -d '' f; do
            vars=$(grep -oE 'set\(\s*[A-Za-z0-9_]+\s+"?\$\{PACKAGE_PREFIX_DIR\}/?"?\s*\)' "$f" \
                | sed -E 's/set\(\s*([A-Za-z0-9_]+).*/\1/' | paste -sd'|' || true)
            vars="_IMPORT_PREFIX|PACKAGE_PREFIX_DIR${vars:+|$vars}"
            _splitDevSed import-prefix-include "$f" \
                -e "s#\\\$\{($vars)\}/include([/\"; )]|\$)#$dev/include\2#g"
            if [ -n "$libs" ]; then
                _splitDevSed import-prefix-lib "$f" \
                    -e "s#\\\$\{($vars)\}/(lib|lib64|bin|share)([/\"; )]|\$)#$out/\2\3#g"
            fi
        done < <(grep -lZE '_IMPORT_PREFIX|PACKAGE_PREFIX_DIR' "$exportdir"/*.cmake || true)
    done < <(find "$dev" -type f -name '*.cmake' -exec grep -lE '_IMPORT_PREFIX|PACKAGE_PREFIX_DIR' {} + 2>/dev/null | xargs -r -n1 dirname | sort -u)

    # pkg-config files moved to dev still say prefix=$out.
    for d in "$dev/lib/pkgconfig" "$dev/lib64/pkgconfig" "$dev/share/pkgconfig"; do
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
