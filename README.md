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
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/preview.webp"/>
</p>

## Previews

<details>
  <summary>🌻 Latte</summary>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/latte.webp"/>
</details>
<details>
  <summary>🪴 Frappé</summary>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/frappe.webp"/>
</details>
<details>
  <summary>🌺 Macchiato</summary>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/macchiato.webp"/>
</details>
<details>
  <summary>🌿 Mocha</summary>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/mocha.webp"/>
</details>

## Usage

1. Import the NixOS and [home-manager](https://github.com/nix-community/home-manager) modules

<details>
<summary>With Flakes</summary>

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, catppuccin, home-manager }: {
    host = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        {
          home-manager.users.user = {
            modules = [
              catppuccin.homeManagerModules.catppuccin
            ];
          };
        }
      ];
    };
  };
}
```

</details>

<details>
<summary>Without Flakes</summary>

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
sudo nix-channel --update
```

```nix
_: {
  imports = [
    <home-manager/nixos>
    <catppuccin/modules/nixos>
  ];

  home-manager.users.user = {
    modules = [
      <catppuccin/modules/home-manager>
    ];
  };
}

```

</details>

2. Choose your desired flavour with `catppuccin.flavour`

<details>
<summary>Example</summary>

```nix
_: {
  catppuccin.flavour = "mocha";
}
```

</details>

3. Enable for supported programs with `catppucin.enable = true;`

<details>
<summary>Example</summary>

```nix
_: {
  programs.starship = {
      enable = true;
      catppuccin.enable = true;
  };
}
```

</details>

<!-- this section is optional -->
## 🙋 FAQ

- Q: **"How do I know what programs are supported?"**\
  A: You can find supported programs [here](https://github.com/catppuccin/nix/tree/main/modules/home-manager)

## 💝 Thanks to

- [Stonks3141](https://github.com/Stonks3141)
- [getchoo](https://github.com/getchoo)

&nbsp;

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
	Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
	<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
