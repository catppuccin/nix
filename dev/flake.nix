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
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Evaluate each of our modules for different systems
        nixosConfiguration = self.nixosConfigurations.pepperjack-pc.extendModules {
          modules = [
            (
              { lib, ... }:

              {
                nixpkgs.pkgs = lib.mkForce pkgs;
              }
            )
          ];
        };

        homeConfiguration = self.homeConfigurations.pepperjack.extendModules {
          modules = [
            (
              { lib, ... }:

              {
                _module.args.pkgs = lib.mkForce pkgs;
              }
            )
          ];
        };

        fullEval =
          # NixOS includes the home-manager configuration
          if pkgs.stdenv.hostPlatform.isLinux then
            nixosConfiguration.config.system.build.toplevel.outPath
          else
            homeConfiguration.activationPackage.outPath;

        mkOptionsJSONFrom =
          eval:

          let
            # This should point to where you can view our module files
            filesLink = "https://github.com/catppuccin/nix/blob/${
              lib.removeSuffix "-dirty" catppuccin.rev or catppuccin.dirtyRev or "main"
            }";

            # And replace the declarations of our modules with that link
            rootPath = lib.removeSuffix "/dev/../." inputs.catppuccin.outPath; # HACK(@getchoo): Outpaths of subflakes are relative, womp womp
            replaceDeclaration = lib.replaceString rootPath filesLink;
          in

          (pkgs.nixosOptionsDoc {
            options = { inherit (eval.options) catppuccin; };

            transformOptions =
              opt: lib.recursiveUpdate opt { declarations = map replaceDeclaration opt.declarations; };
          }).optionsJSON;
      in

      {
        checks = lib.filterAttrs (lib.const lib.isDerivation) catppuccin.packages.${system} or { } // {
          module-eval = lib.deepSeq fullEval pkgs.emptyFile;
        };

        packages = {
          nixosOptionsJSON = mkOptionsJSONFrom nixosConfiguration;
          homeOptionsJSON = mkOptionsJSONFrom homeConfiguration;
        };
      }
    )
    // (
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in

      {
        homeConfigurations = {
          pepperjack = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              pepperjackHomeModule
              { home.username = "pepperjack"; }
            ];
          };
        };

        nixosConfigurations = {
          pepperjack-pc = nixpkgs.lib.nixosSystem {
            modules = [
              inputs.home-manager.nixosModules.default
              catppuccin.nixosModules.catppuccin
              catppuccinEnableModule
              (catppuccin + "/modules/tests/nixos.nix")

              (
                { config, ... }:

                {
                  # Silence, convenient safety assertions!!!!
                  fileSystems."/" = {
                    label = "root";
                  };

                  # NOTE: This isn't required for NixOS. But it is for home-manager!
                  system.stateVersion = config.system.nixos.release;

                  nixpkgs = { inherit pkgs; };

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
        };
      }
    );
}
