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
    { nixpkgs, catppuccin, ... }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};

        kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;
        callTest = lib.flip pkgs.callPackage { inherit (inputs) home-manager; };

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
            options = lib.removeAttrs eval.options [ "_module" ];

            transformOptions =
              opt: lib.recursiveUpdate opt { declarations = replaceDeclarations opt.declarations; };
          }).optionsJSON;
      in

      {
        checks = catppuccin.packages.${system} or { } // {
          module-test = callTest (
            catppuccin + "/modules/tests/${if (kernelName == "linux") then "nixos" else kernelName}.nix"
          );
        };

        packages = {
          nixosOptionsJSON = mkOptionsJSONFrom catppuccin.nixosModules.catppuccin;
          homeOptionsJSON =
            mkOptionsJSONFrom
              (catppuccin.homeModules or catppuccin.homeManagerModules).catppuccin;
        };
      }
    );
}
