{ lib
, nixosOptionsDoc
,
}: { version
   , modules
   ,
   }:
let
  eval = lib.evalModules {
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
  };

  doc = nixosOptionsDoc {
    options = lib.filterAttrs (n: lib.const (!(lib.elem n [ "_module" "system" ]))) eval.options;
    documentType = "none";
    revision = version;
  };
in
doc.optionsCommonMark
