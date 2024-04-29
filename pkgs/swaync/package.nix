{
  lib,
  fetchurl,
  linkFarm,
}:

let
  version = "0.2.3";

  artifactHashes = {
    "frappe.css" = "sha256-9vfro7HpA2T5bk1So8kjUKSXwe5Qnqji7bhs5ASs/Pg=";
    "latte.css" = "sha256-Xp7BekqhHUVTiEMMKKeEO9jlL1wtujlFSU0SINNtWZQ=";
    "macchiato.css" = "sha256-LMm6nWn1JPPgj5YpppwFG3lXTtXem5atlIvqrDxd0bM=";
    "mocha.css" = "sha256-Hie/vDt15nGCy4XWERGy1tUIecROw17GOoasT97kIfc=";
  };
in

linkFarm "catppuccin-swaync-${version}" (
  lib.mapAttrs (
    artifactName: hash:

    fetchurl {
      url = "https://github.com/catppuccin/swaync/releases/download/v${version}/${artifactName}";
      inherit hash;
    }
  ) artifactHashes
)
