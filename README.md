<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://nixos.org">Nix</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
	<a href="https://github.com/catppuccin/nix/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/nix?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/nix/issues"><img src="https://img.shields.io/github/issues/catppuccin/nix?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
	<a href="https://github.com/catppuccin/nix/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/nix?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
	<img src="assets/previews/preview.webp"/>
</p>

## Previews

<details>
  <summary>🌻 Latte</summary>
  <img src="assets/previews/latte.webp"/>
</details>
<details>
  <summary>🪴 Frappé</summary>
  <img src="assets/previews/frappe.webp"/>
</details>
<details>
  <summary>🌺 Macchiato</summary>
  <img src="assets/previews/macchiato.webp"/>
</details>
<details>
  <summary>🌿 Mocha</summary>
  <img src="assets/previews/mocha.webp"/>
</details>

## Usage

You will probably want to see our [Getting started guide](http://nix.catppuccin.com/getting-started/index.html), but as a TLDR:

1. Import the [NixOS](https://nixos.org) and [home-manager](https://github.com/nix-community/home-manager) modules

<details>
<summary>With Flakes</summary>

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, catppuccin, home-manager }: {
    # for nixos module home-manager installations
    nixosConfigurations.pepperjacksComputer = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        catppuccin.nixosModules.catppuccin
        # if you use home-manager
        home-manager.nixosModules.home-manager

        {
          # if you use home-manager
          home-manager.users.pepperjack = {
            imports = [
              ./home.nix
              catppuccin.homeManagerModules.catppuccin
            ];
          };
        }
      ];
    };

    # for standalone home-manager installations
    homeConfigurations.pepperjack = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
        catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
```

</details>

<details>
<summary>With Nix Channels</summary>

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update
```

For [NixOS module installations](https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module):

```nix
{
  imports = [
    <catppuccin/modules/nixos>
    # if you use home-manager
    <home-manager/nixos>
  ];

  # if you use home-manager
  home-manager.users.pepperjack = {
    imports = [
      <catppuccin/modules/home-manager>
    ];
  };
}

```

For [standalone installations](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

```nix
{
  imports = [
    <catppuccin/modules/home-manager>
  ];

  home.username = "pepperjack";
  programs.home-manager.enable = true;
}
```

</details>

2. Choose your desired flavor with `catppuccin.flavor`

```nix
{
  catppuccin.flavor = "mocha";
}
```

3. Enable for supported programs

```nix
{
  catppuccin.starship.enable = true;
}
```

4. Enable for all available programs you're using!

```nix
{
  catppuccin.enable = true;
}
```

## 🙋 FAQ

- Q: **"How do I know what programs are supported?"**\
  A: You can find programs supported through home-manager [here](https://nix.catppuccin.com/search/rolling/?scope=home-manager+modules),
  and NixOS modules [here](https://nix.catppuccin.com/search/rolling/?scope=NixOS+modules)

- Q: **"How do I set `catppuccin.enable` for everything I use?"**\
  A: You can set `catppuccin.enable` globally through home-manager [here](https://nix.catppuccin.com/search/rolling/?option_scope=1&option=catppuccin.enable),
  and NixOS modules [here](https://nix.catppuccin.com/search/rolling/?option_scope=0&option=catppuccin.enable)

- Q: **"What versions of NixOS and home-manager are supported?"**\
  A: We primarily support the `unstable` branch, but try our best to support the current stable release.
  You can check if your stable release is currently supported at [status.nixos.org](https://status.nixos.org/)

- Q: **"How do I fix the error: ... during evaluation because the option 'allow-import-from-derivation' is disabled"**\
  A: Some ports need to read and/or manipulate remote resources, resulting in Nix performing [IFD](https://nix.dev/manual/nix/latest/language/import-from-derivation).

  <details>
  <summary>Disable modules that use IFD</summary>
  
  ```nix
  {
    catppuccin = {
      cava.enable = false;
      gh-dash.enable = false;
      imv.enable = false;
      swaylock.enable = false;
      mako.enable = false;
    };
  }
  ```
  </details>

## 💝 Thanks to

- [Stonks3141](https://github.com/Stonks3141)
- [getchoo](https://github.com/getchoo)

&nbsp;

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
	Copyright &copy; 2023-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
	<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
