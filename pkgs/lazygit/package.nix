{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "lazygit";

  installTargets = [ "themes-mergable" ];

  # lazygit's config migration moves gui.authorColors to gui.theme.authorColors and
  # rewrites every file it loads, but the merged theme is read-only here and a failed
  # write aborts startup. Emit the current location instead. Remove once the upstream
  # port template nests authorColors under theme:.
  postInstall = ''
    for theme in "$out"/*/*.yml; do
      grep -q '^  authorColors:$' "$theme" || continue

      awk '
        /^  authorColors:$/ { blank = 0; nest = 1; print "    authorColors:"; next }
        nest { print "  " $0; next }
        /^$/ { blank++; next }
        { while (blank > 0) { print ""; blank-- } print }
      ' "$theme" > "$theme.tmp"

      if grep -q '^  authorColors:$' "$theme.tmp"; then
        echo "failed to nest authorColors in $theme" >&2
        exit 1
      fi

      mv "$theme.tmp" "$theme"
    done
  '';
}
