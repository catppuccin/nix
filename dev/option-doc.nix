{ lib
, nixosOptionsDoc
,
}: { version
   , modules
   ,
   }:
let
  eval = lib.evalModules {
    modules = modules ++ [{ _module.check = false; }];
  };

  doc = nixosOptionsDoc {
    options = lib.filterAttrs (n: _: n != "_module") eval.options;
    documentType = "none";
    revision = version;
  };
in
doc.optionsCommonMark
