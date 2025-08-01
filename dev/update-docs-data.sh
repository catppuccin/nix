#!/usr/bin/env bash
set -euo pipefail

root="$(dirname "$0")/.."

log() {
  echo "=> $*"
}

usage() {
  echo "Usage: $0 <version_name> [flake_ref] [<nix_build_arguments>...]"
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

readonly version_name="$1"
shift
if [[ -n ${1:-} ]]; then
  readonly flake_ref="$1"
  shift
else
  readonly flake_ref="$root/dev"
fi

for type in "nixos" "home"; do
  nix build \
    --no-link --print-out-paths \
    "$flake_ref#${type}OptionsJSON" \
    "$@" |
    xargs -I {} cp {}/share/doc/nixos/options.json "$root"/docs/data/"$version_name"-"$type"-options.json
  log "generated '$type' options for version '$version_name'"
done
