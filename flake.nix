{
  description = "Soothing pastel theme for Nix";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # home-manager
    alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    bottom = {
      url = "github:catppuccin/bottom";
      flake = false;
    };
    btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
    lazygit = {
      url = "github:catppuccin/lazygit";
      flake = false;
    };
    polybar = {
      url = "github:catppuccin/polybar";
      flake = false;
    };
    starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    sway = {
      url = "github:catppuccin/sway";
      flake = false;
    };

    # nixos
    grub = {
      url = "github:catppuccin/grub";
      flake = false;
    };
  };

  outputs = inputs: (import ./outputs.nix inputs); # yes these parantheseis are unneeded, but i wanted to get around a statix warning
}
