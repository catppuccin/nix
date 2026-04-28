{ vscode-utils, ... }:

vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    name = "catppuccin-vsc-icons";
    publisher = "catppuccin";
    version = "1.26.0";
    hash = "sha256-V1ZhNtCouo0EDrblvoZsiMy7BPPSGdOn5SoZl4kA/z0=";
  };
}
