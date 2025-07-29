#!/usr/bin/env bash
set -euo pipefail

log() {
  echo "=> $*"
}

update_options() {
  readonly version_name="$1"
  shift
  for type in "nixos" "home"; do
    nix build \
      --no-link --print-out-paths \
      "./dev#${type}OptionsJSON" \
      "$@" |
      xargs -I {} cp {}/share/doc/nixos/options.json docs/data/"$version_name"-"$type"-options.json
    log "generated '$type' options for version '$version_name'"
  done
}

update_options main
