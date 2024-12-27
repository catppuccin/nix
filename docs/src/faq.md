# FAQ

- Q: **"How do I know what programs are supported?"**\
  A: You can find programs supported through home-manager [here](https://nix.catppuccin.com/search/rolling/?scope=home-manager+modules),
  and NixOS modules [here](https://nix.catppuccin.com/search/rolling/?scope=NixOS+modules)

- Q: **"How do I set `catppuccin.enable` for everything I use?"**\
  A: You can set `catppuccin.enable` globally through home-manager [here](https://nix.catppuccin.com/search/rolling/?option_scope=1&option=catppuccin.enable),
  and NixOS modules [here](https://nix.catppuccin.com/search/rolling/?option_scope=0&option=catppuccin.enable)

- Q: **"What versions of NixOS and home-manager are supported?"**\
  A: We primarily support the `unstable` branch, but try our best to support the current stable release.
  You can check if your stable release is currently supported at [status.nixos.org](https://status.nixos.org/)

- Q: **"How do I fix the error: ... during evaluation because the option 'allow-import-from-derivation' is disabled"**\
  A: Some ports need to read and/or manipulate remote resources, resulting in Nix performing [IFD](https://nix.dev/manual/nix/latest/language/import-from-derivation).

  <details>
  <summary>Disable modules that use IFD</summary>
  
  ```nix
  {
    catppuccin = {
      cava.enable = false;
      gh-dash.enable = false;
      imv.enable = false;
      swaylock.enable = false;
      mako.enable = false;
    };
  }
  ```
  </details>
