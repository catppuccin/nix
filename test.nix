inputs:
let
  common = {
    catppuccin = {
      enable = true;
      flavour = "mocha";
    };
  };

  # shorthand enable
  enable = { enable = true; };
in
{
  name = "module-test";

  nodes.machine = { lib, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
      ./modules/nixos
      common
    ];

    boot.loader.grub = enable;

    console = enable;

    programs.dconf = enable; # required for gtk

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
        rio = enable;
        rofi = enable;
        skim = enable;
        starship = enable;
        swaylock = enable;
        tmux = enable;
        yazi = enable;
        zathura = enable;
        zellij = enable;
      };

      gtk = lib.recursiveUpdate enable { catppuccin.cursor.enable = true; };

      services = {
        dunst = enable;
        mako = enable;
        polybar =
          enable
          // {
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
