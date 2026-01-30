{ pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  xdg.enable = true;

  i18n.inputMethod = {
    enable = isLinux;
    type = "fcitx5";
  };

  catppuccin = {
    # NOTE: This is enabled by default already, but still
    # listing explicitly so we know it's tested
    glamour.enable = true;

    xfce4-terminal.enable = isLinux;

    # we install the themes but don't apply them so we can test kvantum, qt5ct
    # and qt6ct
    kvantum.assertStyle = false;
    qt5ct = {
      enable = true;
      assertStyle = false;
    };
  };

  # For `catppuccin.gtk.icon`
  gtk.enable = isLinux;

  programs = {
    # keep-sorted start block=yes sticky_comments=yes
    aerc.enable = true;
    alacritty.enable = true;
    anki.enable = true;
    bat.enable = true;
    bottom.enable = true;
    brave.enable = true;
    broot.enable = true;
    btop.enable = true;
    cava.enable = true;
    chromium.enable = isLinux;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    element-desktop.enable = true;
    eza.enable = true;
    firefox = {
      enable = true;
      profiles.pepperjack = {
        extensions.force = true;
      };
    };
    fish.enable = true;
    foot.enable = isLinux;
    freetube.enable = isLinux;
    fuzzel.enable = isLinux;
    fzf.enable = true;
    gemini-cli.enable = true;
    gh-dash.enable = true;
    ghostty.enable = isLinux;
    git.enable = true;
    gitui.enable = true;
    halloy.enable = true;
    helix.enable = true;
    hyprlock.enable = isLinux;
    imv.enable = isLinux;
    k9s.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    mangohud.enable = isLinux;
    micro.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    newsboat.enable = true;
    obs-studio.enable = isLinux;
    opencode.enable = true;
    qutebrowser.enable = false; # broken package due to python3.13-lxml-html-clean-0.4.2
    rio.enable = true;
    rofi.enable = isLinux;
    sioyek.enable = true;
    skim.enable = true;
    spotify-player.enable = true;
    starship.enable = true;
    swaylock.enable = isLinux;
    television.enable = true;
    thunderbird = {
      enable = isLinux;
      profiles.catppuccin-mocha-mauve.isDefault = true;
    };
    tmux.enable = true;
    tofi.enable = isLinux;
    vesktop.enable = true;
    vicinae.enable = isLinux;
    vivid.enable = true;
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    waybar.enable = isLinux;
    wezterm.enable = true;
    wleave.enable = isLinux;
    wlogout.enable = isLinux;
    yazi.enable = true;
    zathura.enable = true;
    zed-editor.enable = true;
    zellij.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };
    # keep-sorted end
  };

  qt.enable = isLinux;

  services = {
    # keep-sorted start block=yes
    dunst.enable = isLinux;
    mako.enable = isLinux;
    polybar = {
      enable = isLinux;
      script = ''
        polybar top &
      '';
    };
    swaync.enable = isLinux;
    # keep-sorted end
  };

  wayland.windowManager = {
    # keep-sorted start
    hyprland.enable = isLinux;
    sway.enable = isLinux;
    # keep-sorted end
  };
}
