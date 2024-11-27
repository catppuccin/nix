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
  types = {
    flavor = lib.types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ];

    accent = lib.types.enum [
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

  # a -> a
  # this creates a basic attrset only containing an
  # enable and flavor option. `name` should be the name
  # of the module, while `enableDefault` is a boolean
  # representing the default of the created `enable`
  # option. `accentSupport` will add an `accent` option for
  # applicable themes
  mkCatppuccinOption =
    {
      name,
      useGlobalEnable ? true,
      default ? if useGlobalEnable then config.catppuccin.enable else false,
      defaultText ? if useGlobalEnable then "catppuccin.enable" else null,
      accentSupport ? false,
    }:

    {
      enable =
        lib.mkEnableOption "Catppuccin theme for ${name}"
        // (
          {
            inherit default;
          }
          // lib.optionalAttrs (defaultText != null) { inherit defaultText; }
        );

      flavor = lib.mkOption {
        type = ctp.types.flavor;
        default = config.catppuccin.flavor;
        description = "Catppuccin flavor for ${name}";
      };
    }
    // lib.optionalAttrs accentSupport {
      accent = lib.mkOption {
        type = ctp.types.accent;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for ${name}";
      };
    };

  # a -> a -> a
  # see https://nlewo.github.io/nixos-manual-sphinx/development/option-types.xml.html
  mergeEnums = a: b: a.typeMerge b.functor;

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

  # string -> a
  # this is to ensure users are running a supported version of nixos/home-manager
  assertMinimumVersion = version: {
    assertion = lib.versionAtLeast ctp.getModuleRelease version;
    message = "`catppuccin/nix` requires at least version ${version} of NixOS/home-manager";
  };

  # [ module ] -> [ module ]
  # Imports a list of modules with the current library
  applyToModules = map (lib.flip lib.modules.importApply { catppuccinLib = ctp; });
}
