{
  lib,
  fetchurl,
  linkFarm,
}:

let
  version = "1.0.1";

  artifactHashes = {
    "frappe.css" = "sha256-CZezkBA43opa0aYggbCwxgqQVCBgRpLsRB0kWzP7oio=";
    "latte.css" = "sha256-nOaSeCxL0ah4eGDFNgNC7mWMTHW6Z5MoQx9XJbvkoac=";
    "macchiato.css" = "sha256-jN7oHf075g463+pPtiTJl3OTXMQjQ+O+OS8L4cCTipI=";
    "mocha.css" = "sha256-EKTAKCU9HlxrrVjNhyMRq7WGfz8DM9IFPUIEGl3nHbo=";
  };
in

linkFarm "catppuccin-swaync-${version}" (
  lib.mapAttrs (
    artifactName: hash:

    fetchurl {
      url = "https://github.com/catppuccin/swaync/releases/download/v${version}/catppuccin-${artifactName}";
      inherit hash;
    }
  ) artifactHashes
)
