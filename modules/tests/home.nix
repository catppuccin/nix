{ lib, pkgs, ... }:

{
  imports = [
    ../home-manager
    ./common.nix
  ];

  xdg.enable = true;

  home = {
    username = lib.fileContents ./username.txt;
    stateVersion = lib.mkDefault "23.11";
  };

  manual.manpages.enable = lib.mkDefault false;

  i18n.inputMethod.enabled = "fcitx5";

  programs = {
    aerc.enable = true;
    alacritty.enable = true;
    bat.enable = true;
    bottom.enable = true;
    brave.enable = true;
    btop.enable = true;
    cava.enable = true;
    chromium.enable = true;
    fish.enable = true;
    foot.enable = true;
    freetube.enable = true;
    fuzzel.enable = true;
    fzf.enable = true;
    gh-dash.enable = true;
    ghostty.enable = true;
    git = {
      enable = true;
      delta.enable = true;
    };
    gitui.enable = true;
    # this is enabled by default already, but still
    # listing explicitly so we know it's tested
    glamour.catppuccin.enable = true;
    helix.enable = true;
    hyprlock.enable = true;
    imv.enable = true;
    k9s.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    micro.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    newsboat.enable = true;
    obs-studio.enable = true;
    rio.enable = true;
    rofi.enable = true;
    skim.enable = true;
    spotify-player.enable = true;
    starship.enable = true;
    swaylock.enable = true;
    tmux.enable = true;
    tofi.enable = true;
    thunderbird = {
      enable = true;
      profiles.catppuccin-mocha-mauve.isDefault = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    waybar.enable = true;
    wlogout.enable = true;
    yazi.enable = true;
    zathura.enable = true;
    zed-editor.enable = true;
    zellij.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  services = {
    dunst.enable = true;
    mako.enable = true;
    polybar = {
      enable = true;
      script = ''
        polybar top &
      '';
    };
    swaync.enable = true;
  };

  wayland.windowManager.sway.enable = true;
  wayland.windowManager.hyprland.enable = true;
}
