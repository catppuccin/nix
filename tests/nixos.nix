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
        uid = 1000;
      };

      virtualisation = {
        memorySize = 4096;
        writableStore = true;
      };

      home-manager.users.test = {
        imports = [ ./home.nix ];
      };
    };

  testScript =
    { nodes, ... }:
    let
      user = nodes.machine.users.users.test;
    in
    ''
      start_all()

      with subtest("Wait for startup"):
        machine.wait_for_unit("multi-user.target")

      with subtest("Activate home-manager environment"):
        # HACK: Re-run home-manager activation
        #
        # As of 24.11, home-manager is activated via a oneshot unit
        # `wait_for_unit()` can't handle this, so we run here again with `systemctl`
        # https://github.com/NixOS/nixpkgs/issues/62155
        machine.systemctl("start home-manager-${user.name}.service")
    '';
}
