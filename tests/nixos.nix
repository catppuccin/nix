{ testers, home-manager }:
testers.runNixOSTest {
  name = "module-test";

  nodes.machine =
    { lib, pkgs, ... }:
    {
      imports = [
        home-manager.nixosModules.default
        ../modules/nixos
        ./common.nix
      ];

      boot = {
        loader.grub.enable = true;
        plymouth.enable = true;
      };

      services = {
        displayManager.sddm = {
          enable = true;
          package = pkgs.kdePackages.sddm; # our module/the upstream port requires the qt6 version
        };
        xserver.enable = true; # required for sddm
      };

      console.enable = true;

      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
      };

      users.users.test = {
        isNormalUser = true;
        home = "/home/test";
      };

      virtualisation = {
        memorySize = 4096;
        writableStore = true;
      };

      home-manager.users.test = {
        imports = [ ./home.nix ];
      };
    };

  testScript = _: ''
    machine.start()
    machine.wait_for_unit("home-manager-test.service")
    machine.wait_until_succeeds("systemctl status home-manager-test.service")
    machine.succeed("echo \"system started!\"")
  '';
}
