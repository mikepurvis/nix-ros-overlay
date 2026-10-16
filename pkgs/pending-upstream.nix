# nixpkgs changes this overlay relies on that haven't landed yet. Each one
# mirrors its upstream PR and turns itself off once nixpkgs has the change,
# so it can be deleted after the next nixpkgs bump past the merge. Listed in
# PENDING-UPSTREAM.md.
self: super: {

  # Until NixOS/nixpkgs#568868 lands: split vtk into out and dev, so its
  # propagated dependencies' dev outputs (Qt, Boost, HDF5, X11 ...) stay out
  # of runtime closures. Mirrors that PR, and turns itself off once nixpkgs'
  # vtk has a dev output.
  vtk = if super.vtk ? dev then super.vtk else super.vtk.overrideAttrs (old: {
    outputs = [ "out" "dev" ];
    # VTK refuses an absolute install destination for its CMake files, so the
    # split happens after install; vtk-prefix.cmake then resolves to dev, which
    # is right once the module hierarchy (lib/vtk) moves there too.
    postInstall = (old.postInstall or "") + ''
      moveToOutput lib/vtk "$dev"
    '';
    postFixup = builtins.replaceStrings [ "$out/lib/cmake/vtk" ] [ "$dev/lib/cmake/vtk" ] (old.postFixup or "") + ''
      substituteInPlace $dev/lib/cmake/vtk/*-targets-*.cmake \
        --replace-quiet "\''${_IMPORT_PREFIX}/lib/" "$out/lib/" \
        --replace-quiet "\''${_IMPORT_PREFIX}/bin/" "$out/bin/"
    '';
  });

  # Until NixOS/nixpkgs#569163 lands: split pagmo2, the last thing holding
  # boost-dev and ipopt-dev in desktop_full's runtime closure (via vtk's
  # openturns). Its CMake package hardcodes $out as the import prefix, so
  # headers are installed to dev directly rather than moved there.
  pagmo2 = if super.pagmo2 ? dev then super.pagmo2 else super.pagmo2.overrideAttrs (old: {
    outputs = [ "out" "dev" ];
    postPatch = (old.postPatch or "") + ''
      substituteInPlace CMakeLists.txt \
        --replace-fail '$<INSTALL_INTERFACE:include>' '$<INSTALL_INTERFACE:''${CMAKE_INSTALL_INCLUDEDIR}>' \
        --replace-fail 'DESTINATION include)' 'DESTINATION ''${CMAKE_INSTALL_INCLUDEDIR})' \
        --replace-fail 'DESTINATION include/pagmo)' 'DESTINATION ''${CMAKE_INSTALL_INCLUDEDIR}/pagmo)'
    '';
  });
}
