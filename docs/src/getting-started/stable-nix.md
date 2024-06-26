# Stable Nix

When using stable Nix, we have a couple options for installing `catppuccin/nix`

## With `npins`

[`npins`](https://github.com/andir/npins) provides a way to easily ["pin"](https://nix.dev/tutorials/first-steps/towards-reproducibility-pinning-nixpkgs) and update external dependencies for your configurations.

Assuming you have followed [their getting started guide](https://github.com/andir/npins#getting-started), you can run the following:

```sh
npins add --name catppuccin github catppuccin nix
```

And in your system configuration:

```nix
let
  sources = import ./npins;
in
{
  imports = [
    (sources.catppuccin + "/modules/nixos")
  ];

  # if you use home-manager
  home-manager.users.pepperjack = {
    imports = [
      (sources.catppuccin + "/modules/home-manager")
    ];
  };
}
```

or if you use a [standalone installation](https://nix-community.github.io/home-manager/index.html#sec-install-standalone) of `home-manager`

```nix
let
  sources = import ./npins.nix;
in
{
  imports = [
    (sources.catppuccin + "/modules/home-manager")
  ];

  home.username = "pepperjack";
  programs.home-manager.enable = true;
}

```

## With channels

[Nix channels](https://nixos.org/manual/nix/stable/command-ref/nix-channel.html) provide a way for you to easily download, update, and use our modules -- though at the cost of reproducibility across machines.

To add `catppuccin/nix` as a channel, you can run the following:


```sh
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update
```

And in your system configuration:

```nix
{
  imports = [
    <catppuccin/modules/nixos>
  ];

  # if you use home-manager
  home-manager.users.pepperjack = {
    imports = [
      <catppuccin/modules/home-manager>
    ];
  };
}
```

or if you use a [standalone installation](https://nix-community.github.io/home-manager/index.html#sec-install-standalone) of `home-manager`

```nix
{
  imports = [
    <catppuccin/modules/home-manager>
  ];

  home.username = "pepperjack";
  programs.home-manager.enable = true;
}

```

