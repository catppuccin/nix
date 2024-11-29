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
    version = args'.version or (builtins.substring 0 7 finalAttrs.src.rev);

    src =
      args'.src or sources.${finalAttrs.pname} or (fetchCatppuccinPort {
        port = finalAttrs.pname;
        inherit (finalAttrs) rev hash;
        fetchSubmodules = finalAttrs.fetchSubmodules or false;
      });

    nativeBuildInputs = args'.nativeBuildInputs or [ ] ++ [ catppuccinInstallHook ];

    meta = {
      description = "Soothing pastel theme for ${finalAttrs.pname}";
      homepage = "https://github.com/catppuccin/${finalAttrs.pname}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [
        getchoo
        isabelroses
      ];
      platform = lib.platforms.all;
    } // args'.meta or { };
  }
)
