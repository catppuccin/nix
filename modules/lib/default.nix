{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    flip
    importJSON
    mkEnableOption
    mkOption
    mkRenamedOptionModule
    mkSinkUndeclaredOptions
    optional
    optionalAttrs
    stringLength
    substring
    toUpper
    types
    versionAtLeast
    ;

  inherit (lib.modules) importApply;

  inherit (pkgs)
    runCommand
    ;
in

lib.makeExtensible (ctp: {
  types = {
    flavor = types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ];

    accent = types.enum [
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

  /**
    Capitalize the first letter in a string

    # Example

    ```nix
    mkUpper "foo"
    => "Foo"
    ```

    # Type

    ```
    mkUpper :: String -> String
    ```

    # Arguments

    - [str] String to capitalize
  */
  mkUpper = str: (toUpper (substring 0 1 str)) + (substring 1 (stringLength str) str);

  /**
    Reads a YAML file

    # Example

    ```nix
    importYAML ./file.yaml
    ```

    # Type

    ```
    importYAML :: Path -> Any
    ```

    # Arguments

    - [path] Path to YAML file
  */
  importYAML =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.yj ]; } ''
        yj < ${path} > $out
      ''
    );

  /**
    Reads an INI file

    # Example

    ```nix
    importINI ./file.ini
    ```

    # Type

    ```
    importINI :: Path -> Any
    ```

    # Arguments

    - [path] Path to INI file
  */
  importINI =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini < ${path} > $out
      ''
    );

  /**
    Reads a raw INI file

    # Example

    ```nix
    importINIRaw ./file.ini
    ```

    # Type

    ```
    importINIRaw :: Path -> Any
    ```

    # Arguments

    - [path] Path to INI file
  */
  importINIRaw =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini -r < ${path} > $out
      ''
    );

  /**
    Creates an attribute set of standard Catppuccin module options

    # Example

    ```
    mkCatppuccinOption { name = "myProgram"; }
    ```

    # Type

    ```
    mkCatppuccinOption :: AttrSet -> AttrSet
    ```

    # Arguments

    - [name] Name of the module
    - [useGlobalEnable] Whether to enable the module by default when `catppuccin.enable` is set (recommended, defaults to `true`)
    - [default] Default `enable` option value (defaults to `if useGlobalEnable then config.catppuccin.enable else false`)
    - [defaultText] Default `enable` option text (automatic if `null`, defaults to `if useGlobalEnable then "config.catppuccin.enable" else null`)
    - [accentSupport] Add an `accent` option (defaults to `false`)
  */
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
        mkEnableOption "Catppuccin theme for ${name}"
        // (
          {
            inherit default;
          }
          // optionalAttrs (defaultText != null) { inherit defaultText; }
        );

      flavor = mkOption {
        type = ctp.types.flavor;
        default = config.catppuccin.flavor;
        description = "Catppuccin flavor for ${name}";
      };
    }
    // optionalAttrs accentSupport {
      accent = mkOption {
        type = ctp.types.accent;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for ${name}";
      };
    };

  /**
    Merge the given enum types
    See https://nixos.org/manual/nixos/stable/#sec-option-types-custom & https://github.com/NixOS/nixpkgs/pull/363565#issuecomment-2532950341

    # Example

    ```nix
    mergeEnums (lib.types.enum [ 1 2 ]) (lib.types.enum [ 3 4 ])
    => lib.types.enum [ 1 2 3 4 ]
    ```

    # Type

    ```
    mergeEnums :: Enum -> Enum -> Enum
    ```
  */
  mergeEnums = a: b: a.typeMerge b.functor;

  /**
    Returns the current release version of nixos or home-manager.
    Throws an evaluation error if neither are found

    # Example

    ```nix
    getModuleRelease
    => "24.11"
    ```

    # Type

    ```
    getModuleRelease :: String
    ```
  */
  getModuleRelease =
    config.home.version.release or config.system.nixos.release
      or (throw "Couldn't determine release version!");

  /**
    Create options only if the current module release is more than a given version

    # Example

    ```nix
    mkVersionedOpts "24.11" { myOption = lib.mkOption { ... }; }
    => { myOption = { ... }; }
    ```

    # Type

    ```
    mkVersionedOpts :: String -> AttrSet -> AttrSet
    ```

    # Arguments

    - [minVersion] Minimum module release to create options for
    - [options] Conditional options
  */
  mkVersionedOpts =
    minVersion: options:
    if versionAtLeast ctp.getModuleRelease minVersion then options else mkSinkUndeclaredOptions { };

  /**
    Assert the current module release is >= the given version

    # Example

    ```nix
    assertMinimumVersion "24.11";
    => { ... }
    ```

    # Type

    ```
    getModuleRelease :: String -> AttrSet
    ```

    # Arguments

    - [version] Minimum version required
    ```
  */
  assertMinimumVersion = version: {
    assertion = versionAtLeast ctp.getModuleRelease version;
    message = "`catppuccin/nix` requires at least version ${version} of NixOS/home-manager";
  };

  /**
    Imports the given modules with the current library

    # Example

    ```nix
    applyToModules [ ./module.nix ]
    => [ { ... } ]
    ```

    # Type

    ```
    applyToModules :: [ Module ] -> [ Module ]
    ```

    # Arguments

    - [modules] Modules to import
    ```
  */
  applyToModules = map (flip importApply { catppuccinLib = ctp; });

  /**
    Apply `mkRenamedOptionModule` to a set of standard Catppuccin module options (like those created by `mkCatppuccinOption`)

    # Example

    ```nix
    mkRenamedCatppuccinOptions { from = [ "myProgram" "catppuccin" ]; to = [ "myProgram" ]; }
    => [ { ... } ]
    ```

    # Type

    ```
    mkRenamedCatppuccinOptions :: AttrSet -> [ Module ]
    ```

    # Arguments

    - [from] Path to original option
    - [to] Path to new option (relative to the root `catppuccin` namespace)
    - [accentSupport] Whether to alias `accent` options (defaults to false)
    ```
  */
  mkRenamedCatppuccinOptions =
    {
      from,
      to,
      accentSupport ? false,
    }:
    [
      (mkRenamedOptionModule
        (
          from
          ++ [
            "enable"
          ]
        )
        [
          "catppuccin"
          to
          "enable"
        ]
      )

      (mkRenamedOptionModule
        (
          from
          ++ [
            "flavor"
          ]
        )
        [
          "catppuccin"
          to
          "flavor"
        ]
      )
    ]
    ++ optional accentSupport (
      mkRenamedOptionModule
        (
          from
          ++ [
            "accent"
          ]
        )
        [
          "catppuccin"
          to
          "accent"
        ]
    );
})
