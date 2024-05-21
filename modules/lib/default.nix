{
  config,
  lib,
  pkgs,
  ...
}:
let
  # this is a recursive attribute with all the functions below
  inherit (lib) ctp;
in
{
  # string -> type -> string -> a -> a
  # this is an internal function and shouldn't be
  # used unless you know what you're doing. it takes
  # a string (the name of the property, i.e., flavour
  # or accent), the type of the property, the name of
  # the module, followed by local config attrset
  mkBasicOpt =
    attr: type: name:
    lib.mkOption {
      inherit type;
      default = config.catppuccin.${attr};
      description = "Catppuccin ${attr} for ${name}";
    };

  # string -> a -> a
  # this creates a flavour option for modules
  # the first string should be the name of the module,
  # followed by the local config attrset
  mkFlavourOpt = ctp.mkBasicOpt "flavour" ctp.types.flavourOption;

  types = {
    flavourOption = lib.types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ];
    accentOption = lib.types.enum [
      "blue"
      "flamingo"
      "green"
      "lavender"
      "maroon"
      "mauve"
      "peach"
      "pink"
      "red"
      "rosewater"
      "sapphire"
      "sky"
      "teal"
      "yellow"
    ];
  };

  # string -> string
  # this capitalizes the first letter in a string,
  # which is sometimes needed in order to format
  # the names of themes correctly
  mkUpper =
    str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);

  # a -> path -> a
  # fromJSON but for yaml (and without readFile)
  # a should be the local pkgs attrset
  fromYaml =
    file:
    let
      # convert to json
      json = pkgs.runCommand "converted.json" { } ''
        ${lib.getExe pkgs.yj} < ${file} > $out
      '';
    in
    builtins.fromJSON (builtins.readFile json);

  # a -> path -> a
  # fromJSON but for ini (and without readFile)
  # a should be the local pkgs attrset
  fromINI =
    file:
    let
      # convert to json
      json = pkgs.runCommand "converted.json" { } ''
        ${lib.getExe pkgs.jc} --ini < ${file} > $out
      '';
    in
    builtins.fromJSON (builtins.readFile json);

  # a -> path -> a
  # fromJSON but for raw ini (and without readFile)
  # a should be the local pkgs attrset
  fromINIRaw =
    file:
    let
      inherit (builtins) fromJSON readFile;

      # convert to json
      json =
        with pkgs;
        runCommand "converted.json" { } ''
          ${jc}/bin/jc --ini -r < ${file} > $out
        '';
    in
    fromJSON (readFile json);

  # string -> a -> a
  # this creates a basic attrset only containing an
  # enable and flavour option. the fist string should
  # be the name of the module, followed by the local config
  # attrset
  mkCatppuccinOpt = name: {
    enable = lib.mkEnableOption "Catppuccin theme" // {
      default = config.catppuccin.enable;
    };
    flavour = ctp.mkFlavourOpt name;
  };

  # string -> a -> a
  # this creates an accent option for modules
  # the first string should be the name of the module,
  # followed by the local config attrset
  mkAccentOpt = ctp.mkBasicOpt "accent" ctp.types.accentOption;

  # a -> a -> a
  # see https://nlewo.github.io/nixos-manual-sphinx/development/option-types.xml.html
  # by default enums cannot be merged, but they keep their passed value in `functor.payload`.
  # `functor.binOp` can merge those values
  mergeEnums = a: b: lib.types.enum (a.functor.binOp a.functor.payload b.functor.payload);

  # string
  # returns the current release version of nixos or home-manager. throws an evaluation error if neither are
  # found
  getModuleRelease =
    config.home.version.release or config.system.nixos.release
      or (throw "Couldn't determine release version!");

  # string -> a -> a
  # if the current module release is less than `minVersion`, all options are made no-ops with
  # `lib.mkSinkUndeclaredOptions`
  mkVersionedOpts =
    minVersion: option:
    if lib.versionAtLeast ctp.getModuleRelease minVersion then
      option
    else
      lib.mkSinkUndeclaredOptions { };
}
