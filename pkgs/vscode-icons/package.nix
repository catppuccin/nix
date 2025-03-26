{ vscode-utils, ... }:

vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    name = "catppuccin-vsc-icons";
    publisher = "catppuccin";
    version = "1.21.0";
    hash = "sha256-rWExJ9XJ8nKki8TP0UNLCmslw+aCm1hR2h2xxhnY9bg=";
  };
}
