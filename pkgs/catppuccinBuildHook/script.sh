# shellcheck shell=bash
# shellcheck disable=SC2154

catppuccinBuildPhase() {
  runHook preBuild

  local templates=()
  concatTo templates whiskersTemplates
  echoCmd 'whiskers templates' "${templates[@]}"

  for template in "${templates[@]}"; do
    whiskers "$template"
  done

  runHook postBuild
}

if [ -z "${dontCatppuccinBuild:-}" ] && [ -z "${buildPhase:-}" ]; then
  buildPhase=catppuccinBuildPhase
fi
