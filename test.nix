{ self
, inputs
, ...
}:
let
  common = {
    catppuccin.flavour = "mocha";
    users.users.test = {
      isNormalUser = true;
      home = "/home/test";
    };
  };

  ctpEnable = {
    enable = true;
    catppuccin.enable = true;
  };
in
{
  name = "module-test";

  nodes.machine = { lib, ... }: {
    imports = [
      self.nixosModules.catppuccin
      inputs.home-manager.nixosModules.default
      common
    ];

    boot.loader.grub = ctpEnable;

    programs.dconf.enable = true; # required for gtk

    virtualisation = {
      memorySize = 4096;
      writableStore = true;
    };

    home-manager.users.test = {
      imports = [
        self.homeManagerModules.catppuccin
      ];

      inherit (common) catppuccin;

      home = {
        username = "test";
        stateVersion = lib.mkDefault "23.11";
      };

      manual.manpages.enable = lib.mkDefault false;

      programs = {
        alacritty = ctpEnable;
        bat = ctpEnable;
        bottom = ctpEnable;
        btop = ctpEnable;
        fish = ctpEnable;
        glamour.catppuccin.enable = true;
        helix = ctpEnable;
        home-manager.enable = false;
        kitty = ctpEnable;
        lazygit = ctpEnable;
        micro = ctpEnable;
        neovim = ctpEnable;
        starship = ctpEnable;
        tmux = ctpEnable;
      };

      gtk = ctpEnable;

      services = {
        mako = ctpEnable;
        polybar =
          ctpEnable
          // {
            script = ''
              polybar top &
            '';
          };
      };

      wayland.windowManager.sway = ctpEnable;
      wayland.windowManager.hyprland = ctpEnable;
    };
  };

  testScript = _: ''
    machine.start()
    machine.wait_for_unit("home-manager-test.service")
    machine.wait_until_succeeds("systemctl status home-manager-test.service")
    machine.succeed("echo \"system started!\"")
  '';
}
