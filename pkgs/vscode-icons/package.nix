{ vscode-utils, ... }:

vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    name = "catppuccin-vsc-icons";
    publisher = "catppuccin";
    version = "1.24.0";
    hash = "sha256-2M7N4Ccw9FAaMmG36hGHi6i0i1qR+uPCSgXELAA03Xk=";
  };
}
