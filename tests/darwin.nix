{ pkgs, home-manager }:
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    ./home.nix

    {
      home = {
        homeDirectory = "/Users/test";
      };
    }
  ];
}
