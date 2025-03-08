{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.thunderbird;
  enable = cfg.enable && config.programs.thunderbird.enable;
in
{
  options.catppuccin.thunderbird =
    catppuccinLib.mkCatppuccinOption {
      name = "thunderbird";
      accentSupport = true;
      default = lib.versionAtLeast config.home.stateVersion "25.05" && config.catppuccin.enable;
    }
    // {
      profile = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-${cfg.flavor}-${cfg.accent}";
        description = "The profile name";
      };
    };

  config = lib.mkIf enable {

    # extensions support was added in https://github.com/nix-community/home-manager/pull/6033
    assertions = [ (catppuccinLib.assertMinimumVersion "25.05") ];

    programs.thunderbird = {
      profiles."${cfg.profile}".extensions = [
        (pkgs.runCommandLocal "catppuccin-${cfg.flavor}-${cfg.accent}.thunderbird.theme"
          {
            buildInputs = [ sources.thunderbird ];
            nativeBuildInputs = with pkgs; [
              jq
              unzip
            ];
          }
          ''
            xpi=${sources.thunderbird}/${cfg.flavor}/${cfg.flavor}-${cfg.accent}.xpi
            extId=$(unzip -qc $xpi manifest.json | jq -r .applications.gecko.id)
            # The extensions path shared by all profiles.
            extensionPath="extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            install -Dv $xpi $out/share/mozilla/$extensionPath/$extId.xpi
          ''
        )
      ];
    };
  };
}
