{ vscode-utils, ... }:

vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    name = "catppuccin-vsc";
    publisher = "catppuccin";
    version = "3.16.1";
    hash = "sha256-qEwQ583DW17dlJbODN8SNUMbDMCR1gUH4REaFkQT65I=";
  };
}
