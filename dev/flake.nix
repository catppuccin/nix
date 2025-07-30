{
  description = "Development Flake for catppuccin/nix";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work correctly on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs.stdenv.hostPlatform) isLinux;

        # NOTE: Required for backwards compat with versions < 25.05
        homeModule = (catppuccin.homeModules or catppuccin.homeManagerModules).catppuccin;

        catppuccinEnableModule =
          { pkgs, ... }:

          {
            catppuccin = {
              enable = true;
              sources = {
                # this is used to ensure that we are able to apply
                # source overrides without breaking the other sources
                palette = pkgs.fetchFromGitHub {
                  owner = "catppuccin";
                  repo = "palette";
                  rev = "16726028c518b0b94841de57cf51f14c095d43d8"; # refs/tags/1.1.1~1
                  hash = "sha256-qZjMlZFTzJotOYjURRQMsiOdR2XGGba8XzXwx4+v9tk=";
                };
              };
            };
          };

      in

      {
        checks =
          let
            # Evaluate our modules in different environments for testing
            pepperjackHomeModule =
              {
                config,
                pkgs,
                osConfig,
                ...
              }:

              {
                imports = [
                  homeModule
                  catppuccinEnableModule
                  (catppuccin + "/modules/tests/home.nix")
                ];

                home = {
                  homeDirectory = lib.mkDefault (
                    if pkgs.stdenv.hostPlatform.isDarwin then
                      "/Users/${config.home.username}"
                    else
                      "/home/${config.home.username}"
                  );
                  # See comment in NixOS config below
                  inherit (osConfig.system or self.nixosConfigurations.pepperjack-pc.config.system) stateVersion;
                };
              };

            homeEval = inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ pepperjackHomeModule ];
            };

            nixosEval = nixpkgs.lib.nixosSystem {
              modules = [
                inputs.home-manager.nixosModules.default
                catppuccin.nixosModules.catppuccin
                catppuccinEnableModule
                (catppuccin + "/modules/tests/nixos.nix")

                (
                  { config, ... }:

                  {
                    nixpkgs = { inherit pkgs; };

                    # NOTE: We don't actually care about this, but it's required for home-manager
                    system.stateVersion = config.system.nixos.release;

                    users.users.pepperjack = {
                      isNormalUser = true;
                    };

                    home-manager.users.pepperjack = {
                      imports = [ pepperjackHomeModule ];
                    };
                  }
                )
              ];
            };

            fullEval =
              if isLinux then nixosEval.config.system.build.vm.outPath else homeEval.activationPackage.outPath;
          in

          lib.filterAttrs (lib.const lib.isDerivation) catppuccin.packages.${system} or { }
          // {
            module-eval = lib.deepSeq fullEval pkgs.emptyFile;
          };

        packages =
          let
            # This should point to where you can view our module files
            filesLink = "https://github.com/catppuccin/nix/blob/${
              lib.removeSuffix "-dirty" catppuccin.rev or catppuccin.dirtyRev or "main"
            }";

            # And replace the declarations of our modules with that link
            rootPath = lib.removeSuffix "/dev/../." inputs.catppuccin.outPath; # HACK(@getchoo): Outpaths of subflakes are relative, womp womp
            isOurDeclaration = lib.hasPrefix rootPath;
            replaceDeclaration = lib.replaceString rootPath filesLink;
            replaceDeclarations = map (
              declaration: if (isOurDeclaration declaration) then replaceDeclaration declaration else declaration
            );

            mkOptionsJSONFrom =
              module:

              let
                eval = lib.evalModules {
                  modules = [
                    module
                    { _module.check = false; }
                  ];
                  specialArgs = { inherit pkgs; };
                };
              in

              (pkgs.nixosOptionsDoc {
                # You can also use this for backwards compat with < v1.2: `options = lib.removeAttrs eval.options [ "_module" ];`
                options = { inherit (eval.options) catppuccin; };

                transformOptions =
                  opt: lib.recursiveUpdate opt { declarations = replaceDeclarations opt.declarations; };
              }).optionsJSON;
          in

          {
            nixosOptionsJSON = mkOptionsJSONFrom catppuccin.nixosModules.catppuccin;
            homeOptionsJSON = mkOptionsJSONFrom homeModule;
          };
      }
    );
}
