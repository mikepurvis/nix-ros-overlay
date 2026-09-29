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

splitDevOutput() {
    if [ -z "${dev:-}" ] || [ "$dev" = "$out" ]; then return 0; fi

    moveToOutput include "$dev"
    moveToOutput lib/cmake "$dev"
    moveToOutput lib/pkgconfig "$dev"
    moveToOutput share/pkgconfig "$dev"

    local cmakedir pkgdir pkg entry
    for cmakedir in "$out"/share/*/cmake; do
        [ -d "$cmakedir" ] || continue
        pkgdir=$(dirname "$cmakedir")
        pkg=$(basename "$pkgdir")
        moveToOutput "share/$pkg/cmake" "$dev"

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

    # CMake's own install(EXPORT) files locate everything from _IMPORT_PREFIX,
    # which is computed from the file's own location.
    find "$dev" -type f \( -name '*Targets*.cmake' -o -name '*Export*.cmake' -o -name '*Config.cmake' \) -print0 \
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
}
