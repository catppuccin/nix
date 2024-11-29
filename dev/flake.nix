{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NOTE: This is only to deduplicate inputs
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nuscht-search = {
      url = "github:NuschtOS/search";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    catppuccin-rolling = {
      url = "github:catppuccin/nix";
    };

    catppuccin-v1_1 = {
      url = "https://flakehub.com/f/catppuccin/nix/1.1.*.tar.gz";
    };

    catppuccin-v1_2 = {
      url = "https://flakehub.com/f/catppuccin/nix/1.2.*.tar.gz";
    };

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      self,
      nuscht-search,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      nixpkgsFor = nixpkgs.lib.genAttrs systems (system: {
        unstable = nixpkgs.legacyPackages.${system};
        stable = nixpkgs-stable.legacyPackages.${system};
      });

      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Versions of the modules we want to index in our search
      searchVersions =
        map
          (versionName: {
            inherit versionName;
            catppuccin = inputs."catppuccin-${lib.replaceStrings [ "." ] [ "_" ] versionName}";
          })
          [
            "v1.1"
            "v1.2"
            "rolling"
          ];

      # And the latest stable from that
      latestStableVersion =
        let
          latest = lib.foldl' (
            latest:
            { versionName, ... }:
            if (versionName != "rolling" && lib.versionOlder latest (lib.removePrefix "v" versionName)) then
              versionName
            else
              latest
          ) "0" searchVersions;
        in
        assert lib.assertMsg (latest != "0") "Unable to determine latest stable version!";
        latest;
    in

    {
      apps = forAllSystems (system: {
        serve = {
          type = "app";
          program = lib.getExe self.packages.${system}.site.serve;
        };
      });

      checks = forAllSystems (
        system:

        let
          pkgs = nixpkgsFor.${system};

          callUnstable = lib.flip pkgs.unstable.callPackage { inherit home-manager; };
          callStable = lib.flip pkgs.stable.callPackage { home-manager = home-manager-stable; };
        in

        lib.optionalAttrs pkgs.unstable.stdenv.hostPlatform.isDarwin {
          darwin-test-unstable = callUnstable ../tests/darwin.nix;
          darwin-test-stable = callStable ../tests/darwin.nix;
        }
        // lib.optionalAttrs pkgs.unstable.stdenv.hostPlatform.isLinux {
          nixos-test-unstable = callUnstable ../tests/nixos.nix;
          nixos-test-stable = callStable ../tests/nixos.nix;
        }
      );

      formatter = forAllSystems (system: nixpkgsFor.${system}.unstable.nixfmt-rfc-style);

      packages = forAllSystems (
        system:

        let
          pkgs = nixpkgsFor.${system}.unstable;

          mkSite = pkgs.callPackage ../docs/mk-site.nix { };
          mkSearchInstance = pkgs.callPackage ../docs/mk-search.nix {
            inherit (nuscht-search.packages.${system}) mkMultiSearch;
          };

          search-instances = lib.listToAttrs (
            map (
              { catppuccin, versionName }:
              {
                name = versionName;
                value = mkSearchInstance { inherit catppuccin versionName; };
              }
            ) searchVersions
          );

          redirectTo =
            endpoint:
            pkgs.writeText "index.html" ''
              <meta http-equiv="refresh" content="0;url=${endpoint}">
            '';
        in

        search-instances
        // {
          site = mkSite {
            pname = "catppuccin-nix-site";
            version = self.shortRev or self.dirtyShortRev or "unknown";

            src = ../docs;

            postPatch = "ln -sf ${inputs.catppuccin-rolling + "/CHANGELOG.md"} src/NEWS.md";

            postInstall = ''
              ln -sf ${
                pkgs.linkFarm "search-engines" (
                  [
                    {
                      name = "stable.html";
                      path = redirectTo "/search/${latestStableVersion}/";
                    }
                    {
                      name = "index.html";
                      path = redirectTo "/search/stable.html";
                    }
                  ]
                  ++ map (
                    { versionName, ... }:
                    {
                      name = versionName;
                      path = search-instances.${versionName};
                    }
                  ) searchVersions
                )
              } $out/search
            '';
          };

          default = self.packages.${system}.site;
        }
      );
    };
}
