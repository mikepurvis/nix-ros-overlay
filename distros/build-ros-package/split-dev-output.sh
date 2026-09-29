# Moves the build-time half of a CMake-built ROS package (headers and CMake
# configs) into the dev output, so that the out output, which is all that
# runtime environments reference, no longer carries -dev paths of system
# libraries baked into include-dir and link-library lists.
#
# ament and rosidl write CMake configs that find everything by walking up
# from their own location (${pkg_DIR}/../../../lib, ${pkg_DIR}/../resource),
# which is wrong once share/<pkg>/cmake lives in a different store path from
# lib/ and share/<pkg>. The fixups below turn those into absolute paths:
#
#   - lib/ and bin/ references are rewritten to $out. They have to be
#     absolute, since a library found through $dev would put $dev in the
#     RPATH of every dependent.
#   - The rest of share/<pkg> is symlinked into $dev/share/<pkg>, so that
#     templates and .idl files that other packages look up relative to
#     ${pkg_DIR} still resolve. Those are only read at build time.
#
# include/ moves wholesale, so ${pkg_DIR}/../../../include stays correct.

# Like moveToOutput, but merges into a directory that already exists, as when
# a package honours the absolute CMAKE_INSTALL_INCLUDEDIR for some headers but
# installs others to a hardcoded include/.
#
# Files that baked the absolute $out path of what moved (a config that
# honoured CMAKE_INSTALL_LIBDIR and adds $out/lib/cmake/<pkg> to
# CMAKE_MODULE_PATH, say) are pointed at the new location.
_mergeToDev() {
    [ -e "$out/$1" ] || return 0
    if [ -e "$dev/$1" ]; then
        echo "Merging $out/$1 into $dev/$1"
        cp -a --no-target-directory "$out/$1" "$dev/$1"
        rm -rf "${out:?}/$1"
    else
        moveToOutput "$1" "$dev"
    fi
    { grep -rlZF "$out/$1" "$dev" --include='*.cmake' --include='*.pc' || true; } \
        | xargs -0r sed -i -e "s#$out/$1\([/\"; )]\|\$\)#$dev/$1\1#g"
}

splitDevOutput() {
    if [ -z "${dev:-}" ] || [ "$dev" = "$out" ]; then return 0; fi

    _mergeToDev include
    _mergeToDev lib/cmake
    _mergeToDev lib/pkgconfig
    _mergeToDev share/pkgconfig

    local cmakedir pkgdir pkg entry
    for cmakedir in "$out"/share/*/cmake; do
        [ -d "$cmakedir" ] || continue
        pkgdir=$(dirname "$cmakedir")
        pkg=$(basename "$pkgdir")
        _mergeToDev "share/$pkg/cmake"

        for entry in "$pkgdir"/*; do
            [ -e "$entry" ] || continue
            ln -s "$entry" "$dev/share/$pkg/$(basename "$entry")"
        done

        # ament_cmake_export_libraries, rosidl typesupport libraries, rosidl
        # generator executables and Python modules.
        find "$dev/share/$pkg/cmake" -type f -name '*.cmake' -print0 | xargs -0r sed -i -E \
            -e "s#\\\$\{$pkg""_DIR\}/\.\./\.\./\.\./(lib|bin)([/\"; )]|\$)#$out/\1\2#g" \
            -e "s#\\\$\{CMAKE_CURRENT_LIST_DIR\}/\.\./\.\./\.\./(lib|bin)([/\"; )]|\$)#$out/\1\2#g"
    done

    # Configs installed somewhere else entirely, such as urdfdom_headers'
    # ${CMAKE_INSTALL_LIBDIR}/urdfdom_headers/cmake.
    local d
    while IFS= read -r -d '' d; do
        [ -n "$(find "$d" \( -name '*Config.cmake' -o -name '*-config.cmake' \) -print -quit)" ] || continue
        _mergeToDev "${d#"$out"/}"
    done < <(find "$out" -depth -type d \( -name cmake -o -name CMake \) -print0)

    # CMake's own install(EXPORT) files locate everything from _IMPORT_PREFIX,
    # which is computed from the file's own location.
    { find "$dev" -type f -name '*.cmake' -exec grep -lZE '_IMPORT_PREFIX|PACKAGE_PREFIX_DIR' {} + || true; } \
        | xargs -0r sed -i -E \
            -e "s#\\\$\{(_IMPORT_PREFIX|PACKAGE_PREFIX_DIR)\}/(lib|bin)([/\"; )]|\$)#$out/\2\3#g"

    # pkg-config files moved to dev still say prefix=$out; point includedir at
    # the headers' new home.
    local pcdir
    for pcdir in "$dev/lib/pkgconfig" "$dev/share/pkgconfig"; do
        [ -d "$pcdir" ] || continue
        find "$pcdir" -name '*.pc' -print0 \
            | xargs -0r sed -i -E -e "s#^includedir=\\\$\{prefix\}/include#includedir=$dev/include#"
    done

    # moveToOutput prunes emptied parents, which takes out itself with it for
    # a header-only package.
    mkdir -p "$out"

    # Anything left in out that names dev is a reference cycle; Nix would
    # only say which outputs are involved, so name the files.
    local leaks
    leaks=$(grep -rlF "$dev" "$out" || true)
    if [ -n "$leaks" ]; then
        echo "splitDevOutput: out still references dev in:" >&2
        echo "$leaks" >&2
    fi
}
