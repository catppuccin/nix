{
  lib,
  pkgs,
  home-manager,
}:
(home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ./home.nix

    {
      home = {
        homeDirectory = "/Users/test";
      };

      i18n.inputMethod.enabled = lib.mkForce null;

      programs = {
        cava.enable = lib.mkForce false; # NOTE: this may actually work on darwin, but the package is currently not supported
        foot.enable = lib.mkForce false;
        fuzzel.enable = lib.mkForce false;
        imv.enable = lib.mkForce false;
        mpv.enable = lib.mkForce false; # NOTE: same as cava, but `mpv` fails to build currently
        rofi.enable = lib.mkForce false;
        swaylock.enable = lib.mkForce false;
        tofi.enable = lib.mkForce false;
        waybar.enable = lib.mkForce false;
      };

      qt.enable = lib.mkForce false; # NOTE: same as cava

      services = {
        dunst.enable = lib.mkForce false;
        mako.enable = lib.mkForce false;
        polybar.enable = lib.mkForce false;
      };

      wayland.windowManager = {
        hyprland.enable = lib.mkForce false;
        sway.enable = lib.mkForce false;
      };
    }
  ];
}).activationPackage
