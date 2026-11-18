{ pkgs, ... }:

{
  # Exercise the global light and dark flavors (used by home-assistant)
  catppuccin = {
    lightFlavor = "latte";
    darkFlavor = "macchiato";
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "nodev";
    };
    plymouth.enable = true;
  };

  console.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };

  services = {
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm; # our module/the upstream port requires the qt6 version
    };
    forgejo.enable = true;
    gitea = {
      enable = true;
      settings.server.ROOT_URL = "https://gitea.catppuccin.com";
    };
    home-assistant.enable = true;

    xserver.enable = true; # required for sddm
  };

  programs = {
    fish.enable = true;
  };
}
