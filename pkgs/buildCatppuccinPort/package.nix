{
  lib,
  stdenvNoCC,
  catppuccinInstallHook,
  fetchCatppuccinPort,
  sources,
}:

lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    finalAttrs: args:
    let
      lastModified = args.lastModified or finalAttrs.src.lastModified or null;
    in
    args
    // {
      pname = args.pname or "catppuccin-${finalAttrs.port}";
      version =
        args.version or ("0" + lib.optionalString (lastModified != null) "-unstable-${lastModified}");

      src =
        args.src or sources.${finalAttrs.port} or (fetchCatppuccinPort {
          inherit (finalAttrs) port;
          inherit (finalAttrs) rev hash;
          fetchSubmodules = finalAttrs.fetchSubmodules or false;
        });

      nativeBuildInputs = args.nativeBuildInputs or [ ] ++ [ catppuccinInstallHook ];

      meta = {
        description = "Soothing pastel theme for ${finalAttrs.port}";
        homepage = "https://github.com/catppuccin/${finalAttrs.port}";
        license = lib.licenses.mit;
        maintainers = with lib.maintainers; [
          getchoo
          isabelroses
        ];
        platforms = lib.platforms.all;
      }
      // args.meta or { };
    };
}
