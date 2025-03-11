{
  lib,
  stdenvNoCC,
  catppuccinInstallHook,
  fetchCatppuccinPort,
  sources,
}:

args:

stdenvNoCC.mkDerivation (
  finalAttrs:

  let
    args' = if lib.isFunction args then args finalAttrs else args;
  in

  args'
  // {
    pname = args'.pname or "catppuccin-${finalAttrs.port}";
    version =
      args'.version
        or ("0" + lib.optionalString (finalAttrs ? "lastModified") "-unstable-${finalAttrs.lastModified}");

    src =
      args'.src or sources.${finalAttrs.port} or (fetchCatppuccinPort {
        inherit (finalAttrs) port;
        inherit (finalAttrs) rev hash;
        fetchSubmodules = finalAttrs.fetchSubmodules or false;
      });

    nativeBuildInputs = args'.nativeBuildInputs or [ ] ++ [ catppuccinInstallHook ];

    meta = {
      description = "Soothing pastel theme for ${finalAttrs.port}";
      homepage = "https://github.com/catppuccin/${finalAttrs.port}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [
        getchoo
        isabelroses
      ];
      platform = lib.platforms.all;
    } // args'.meta or { };
  }
)
