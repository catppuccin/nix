{ lib, nixosOptionsDoc }:
{
  version,
  modules ? [ moduleRoot ],
  moduleRoot,
}:
let
  baseDeclarationUrl = "https://github.com/catppuccin/nix/blob/main";
  declarationIsOurs = declaration: lib.hasPrefix (toString moduleRoot) (toString declaration);
  declarationSubpath = declaration: lib.removePrefix (toString ../. + "/") (toString declaration);

  toGithubDeclaration =
    declaration:
    let
      subpath = declarationSubpath declaration;
    in
    {
      url = "${baseDeclarationUrl}/${subpath}";
      name = "<catppuccin/${subpath}>";
    };

  evaluated = lib.evalModules {
    modules = modules ++ [
      {
        options.system.nixos.release = lib.mkOption {
          type = lib.types.str;
          default = lib.trivial.release;
          readOnly = true;
        };

        config = {
          _module.check = false;
        };
      }
    ];
  };

  optionsDoc = nixosOptionsDoc {
    options = builtins.removeAttrs evaluated.options [
      "_module"
      "system"
    ];

    transformOptions =
      opt:
      opt
      // {
        declarations = map (
          declaration: if declarationIsOurs declaration then toGithubDeclaration declaration else declaration
        ) opt.declarations;
      };

    documentType = "none";
    revision = version;
  };
in
optionsDoc.optionsCommonMark
