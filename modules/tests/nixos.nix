{ pkgs, ... }:

{
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
    gitea.enable = true;

    xserver.enable = true; # required for sddm
  };
}
