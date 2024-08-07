# FAQ

- Q: **"How do I know what programs are supported?"**\
  A: You can find programs supported through home-manager [here](options/home-manager-options.md),
  and NixOS modules [here](options/nixos-options.md)

- Q: **"How do I set `catppuccin.enable` for everything I use?"**\
  A: You can set `catppuccin.enable` [globally](options/nixos-options.md#catppuccinenable)

- Q: **"What versions of NixOS and home-manager are supported?"**\
  A: We primarily support the `unstable` branch, but try our best to support the current stable release.
  You can check if your stable release is currently supported at [status.nixos.org](https://status.nixos.org/)

- Q: **"How do I fix the error: ... during evaluation because the option 'allow-import-from-derivation' is disabled"**\
  A: Some ports require extra steps to configure the theme resulting in an [IFD](https://wiki.nixos.org/wiki/Import_From_Derivation).
  You can manually disable that port (when using `catppuccin.enable`).
  <details>
  <summary>All IFD's</summary>

  ```nix
  services = {
    dunst.catppuccin.enable = false;
    mako.catppuccin.enable = false;
  };
  programs = {
    cava.catppuccin.enable = false;
    foot.catppuccin.enable = false;
    gh-dash.catppuccin.enable = false;
    imv.catppuccin.enable = false;
    kitty.catppuccin.enable = false; # IFD is inside HM
    lazygit.catppuccin.enable = false;
    mpv.catppuccin.enable = false;
    swaylock.catppuccin.enable = false;
    tofi.catppuccin.enable = false;
    zathura.catppuccin.enable = false;
  };
  ```
  </details>
