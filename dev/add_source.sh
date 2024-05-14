#!/usr/bin/env bash
set -e

_usage="
Usage: add-source <repo_name> [branch]
repo_name: Name of the repository in the Catppuccin org (required)
branch: Primary branch of the repository (optional, defaults to main)
"

repo_name="${1}"
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
