# shellcheck shell=bash
# shellcheck disable=SC2154

catppuccinInstallPhase() {
  runHook preInstall

  local targets=()
  concatTo targets installTargets=themes
  echoCmd 'install targets' "${targets[@]}"

  if [ "${#targets[@]}" -gt 1 ]; then
    mkdir -p "$out"
  fi

  for target in "${targets[@]}"; do
    if [ -e "$target" ]; then
      mv "$target" "$out"
    fi
  done

  runHook postInstall
}

if [ -z "${dontCatppuccinInstall:-}" ] && [ -z "${installPhase:-}" ]; then
  installPhase=catppuccinInstallPhase
fi
