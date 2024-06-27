{
  testers,
  fetchFromGitHub,
  home-manager,
}:
let
  common = {
    catppuccin = {
      enable = true;
      sources = {
        # this is used to ensure that we are able to apply
        # source overrides without breaking the other sources
        palette = fetchFromGitHub {
          owner = "catppuccin";
          repo = "palette";
          rev = "16726028c518b0b94841de57cf51f14c095d43d8"; # refs/tags/1.1.1~1
          hash = "sha256-qZjMlZFTzJotOYjURRQMsiOdR2XGGba8XzXwx4+v9tk=";
        };
      };
    };
  };

  # shorthand for enabling a module
  enable = {
    enable = true;
  };
in
testers.runNixOSTest {
  name = "module-test";

  nodes.machine =
    { lib, pkgs, ... }:
    {
      imports = [
        home-manager.nixosModules.default
        ./modules/nixos
        common
      ];

      boot = {
        loader.grub = enable;
        plymouth = enable;
      };

      services = {
        displayManager.sddm = enable // {
          package = pkgs.kdePackages.sddm; # our module/the upstream port requires the qt6 version
        };
        xserver.enable = true; # required for sddm
      };

      console = enable;

      users.users.test = {
        isNormalUser = true;
        home = "/home/test";
      };

      virtualisation = {
        memorySize = 4096;
        writableStore = true;
      };

      home-manager.users.test = {
        imports = [
          ./modules/home-manager
          common
        ];

        xdg.enable = true;

        home = {
          username = "test";
          stateVersion = lib.mkDefault "23.11";
        };

        manual.manpages.enable = lib.mkDefault false;

        i18n.inputMethod.enabled = "fcitx5";

        programs = {
          alacritty = enable;
          bat = enable;
          bottom = enable;
          btop = enable;
          cava = enable;
          fish = enable;
          foot = enable;
          fzf = enable;
          gh-dash = enable;
          git = enable // {
            delta = enable;
          };
          gitui = enable;
          # this is enabled by default already, but still
          # listing explicitly so we know it's tested
          glamour.catppuccin.enable = true;
          helix = enable;
          imv = enable;
          k9s = enable;
          kitty = enable;
          lazygit = enable;
          micro = enable;
          mpv = enable;
          neovim = enable;
          newsboat = enable;
          rio = enable;
          rofi = enable;
          skim = enable;
          starship = enable;
          swaylock = enable;
          tmux = enable;
          tofi = enable;
          waybar = enable;
          yazi = enable;
          zathura = enable;
          zellij = enable;
          zsh = enable // {
            syntaxHighlighting = enable;
          };
        };

        qt = enable // {
          platformTheme.name = "kvantum";
          style.name = "kvantum";
        };

        services = {
          dunst = enable;
          mako = enable;
          polybar = enable // {
            script = ''
              polybar top &
            '';
          };
        };

        wayland.windowManager.sway = enable;
        wayland.windowManager.hyprland = enable;
      };
    };

  testScript = _: ''
    machine.start()
    machine.wait_for_unit("home-manager-test.service")
    machine.wait_until_succeeds("systemctl status home-manager-test.service")
    machine.succeed("echo \"system started!\"")
  '';
}
