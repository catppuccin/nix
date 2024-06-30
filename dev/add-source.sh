#!/usr/bin/env bash
set -euo pipefail

_usage="
A wrapper script around \`npins\` for adding sources to catppuccin/nix

Usage: $(basename "$0") repo_name [branch]

Options:

repo_name           Name of the repository in the Catppuccin org
branch              Primary branch of the repository (defaults to main if omitted)
"

repo_name="${1:-}"
branch_name="${2:-main}"

if [ "${repo_name:-}" = "" ]; then
    echo "error: a repository name is required!" >&2
    echo "$_usage"
    exit 1
fi

npins add github \
  catppuccin "$repo_name" \
  --directory ./.sources \
  --branch "$branch_name"
