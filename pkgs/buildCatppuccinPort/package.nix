{
  lib,
  stdenvNoCC,
  catppuccinInstallHook,
  catppuccinBuildHook,
  fetchCatppuccinPort,
  whiskers,
  sources,
}:

lib.extendMkDerivation {
  constructDrv = stdenvNoCC.mkDerivation;

  extendDrvArgs =
    finalAttrs: args:
    let
      lastModified = args.lastModified or finalAttrs.src.lastModified or null;
    in
    {
      pname = args.pname or "catppuccin-${finalAttrs.port}";
      version =
        args.version or ("0" + lib.optionalString (lastModified != null) "-unstable-${toString lastModified}");

      src =
        args.src or sources.${finalAttrs.port} or (fetchCatppuccinPort {
          inherit (finalAttrs) port;
          inherit (finalAttrs) rev hash;
          fetchSubmodules = finalAttrs.fetchSubmodules or false;
        });

      nativeBuildInputs = args.nativeBuildInputs or [ ] ++ [
        catppuccinInstallHook
        catppuccinBuildHook
        whiskers # dep of catppuccin build hook
      ];

      __structuredAttrs = true;
      strictDeps = true;

      whiskersTemplates = args.whiskersTemplates or [ "${finalAttrs.port}.tera" ];

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
