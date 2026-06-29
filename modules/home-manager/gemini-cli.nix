{ ... }:
{ lib, ... }:

{
  imports = [
    (lib.mkRemovedOptionModule [ "catppuccin" "gemini-cli" "enable" ] ''
      Upstream home-manager removed gemini-cli in favor of the
      antigravity-cli which no longer supports the catppuccin theme.
    '')
    (lib.mkRemovedOptionModule [ "catppuccin" "gemini-cli" "flavor" ] ''
      Upstream home-manager removed gemini-cli in favor of the
      antigravity-cli which no longer supports the catppuccin theme.
    '')
  ];
}
