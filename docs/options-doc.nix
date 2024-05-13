{ lib
, nixosOptionsDoc
,
}: { version
   , modules
   ,
   }:
(
  nixosOptionsDoc {
    options =
      builtins.removeAttrs
        (
          lib.evalModules {
            modules = modules ++ [{
              options.system.nixos.release = lib.mkOption {
                type = lib.types.str;
                default = lib.trivial.release;
                readOnly = true;
              };

              config = {
                _module.check = false;
              };
            }];
          }
        ).options [ "_module" "system" ];

    documentType = "none";
    revision = version;
  }
).optionsCommonMark
