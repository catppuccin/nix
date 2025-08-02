# Changelog

## [25.05](https://github.com/catppuccin/nix/releases/tag/v25.05) - 2025-08-01

### 🚨 Breaking Changes

- **modules**: drop support for nixpkgs 24.11 by [@getchoo](https://github.com/getchoo)
- **home-manager/gtk**: remove by [@getchoo](https://github.com/getchoo)

### 🚀 Features

- **fctix5**: add enableRounded option by [@isabelroses](https://github.com/isabelroses)
- **home-manager**: init wlogout module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: add support for chromium and chromium-based browsers by [@HeitorAugustoLN](https://github.com/HeitorAugustoLN)
- **home-manager**: add support for ghostty by [@natecox](https://github.com/natecox)
- **home-manager**: add support for lsd by [@mariovagomarzal](https://github.com/mariovagomarzal)
- **home-manager**: add support for thunderbird by [@nim65s](https://github.com/nim65s)
- **home-manager**: add support for nushell by [@isabelroses](https://github.com/isabelroses)
- **home-manager**: add support for vscode by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for wezterm by [@taranarmo](https://github.com/taranarmo)
- **home-manager**: add support for swaync by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add support for qutebrowser by [@fmway](https://github.com/fmway)
- **home-manager**: add support for sioyak by [@n194](https://github.com/n194)
- **home-manager**: add support for atuin by [@isabelroses](https://github.com/isabelroses)
- **home-manager**: add support for firefox-based browsers by [@different-name](https://github.com/different-name)
- **home-manager**: add support for xfce4-terminal by [@different-name](https://github.com/different-name)
- **home-manager**: add support for element-desktop by [@SchweGELBin](https://github.com/SchweGELBin)
- **home-manager**: add support for vesktop by [@SchweGELBin](https://github.com/SchweGELBin)
- **home-manager**: add support for mangohud by [@SchweGELBin](https://github.com/SchweGELBin)
- **home-manager/firefox**: enable 'default' profile by default by [@different-name](https://github.com/different-name)
- **home-manager/firefox**: use options submodule to apply configuration by [@different-name](https://github.com/different-name)
- **home-manager/hyprlock**: allow using default config for port by [@getchoo](https://github.com/getchoo)
- **home-manager/neovim**: add option for custom settings by [@toodeluna](https://github.com/toodeluna)
- **home-manager/vscode**: allow configuration of build by [@isabelroses](https://github.com/isabelroses)
- **home-manager/vscode**: Add support for per-profile config by [@different-name](https://github.com/different-name)
- **home-manager/vscode-icons**: init by [@isabelroses](https://github.com/isabelroses)
- **home-manager/zed**: accent support by [@isabelroses](https://github.com/isabelroses)
- **home-manager/zed-editor**: icon support by [@42willow](https://github.com/42willow)
- **home-manager/zed-editor**: add ability to enable/disable icons by [@isabelroses](https://github.com/isabelroses)
- **modules**: use package set for port sources by [@getchoo](https://github.com/getchoo)
- **nixos**: add support for gitea/forgejo by [@Lichthagel](https://github.com/Lichthagel)
- **nixos**: Add support for Limine by [@dinckelman](https://github.com/dinckelman)
- global cachix option by [@isabelroses](https://github.com/isabelroses)

### 🐛 Bug Fixes

- **catwalk**: enable useFetchCargoVendor by [@isabelroses](https://github.com/isabelroses)
- **docs**: theming by [@isabelroses](https://github.com/isabelroses)
- **gitea**: controlled by enable [#588](https://github.com/catppuccin/nix/issues/588) by [@luochen1990](https://github.com/luochen1990)
- **home-manager/alacritty**: remove the `general` setting option by [@mariovagomarzal](https://github.com/mariovagomarzal)
- **home-manager/fcitx5**: adjust source by [@isabelroses](https://github.com/isabelroses)
- **home-manager/fcitx5**: support new enable option by [@brian14708](https://github.com/brian14708)
- **home-manager/firefox**: set default profile safely by [@different-name](https://github.com/different-name)
- **home-manager/firefox**: only apply to profiles specified by [@getchoo](https://github.com/getchoo)
- **home-manager/gtk**: pass flavor and not variant by [@isabelroses](https://github.com/isabelroses)
- **home-manager/gtk**: adjust config.gtk.name for new package by [@isabelroses](https://github.com/isabelroses)
- **home-manager/mako**: use settings instead of extraConfig by [@MisileLab](https://github.com/MisileLab)
- **home-manager/rofi**: update to use upstream overhaul by [@isabelroses](https://github.com/isabelroses)
- **home-manager/zed**: correctly apply italics by [@getchoo](https://github.com/getchoo)
- **home-manager/zed**: correctly enable & select accent by [@isabelroses](https://github.com/isabelroses)
- **lib**: set defaultText for flavor and accent for mkCatppuccinOption by [@isabelroses](https://github.com/isabelroses)
- **mako**: use theme directly by [@oliviafloof](https://github.com/oliviafloof)
- **mako**: inherit from theme by [@oliviafloof](https://github.com/oliviafloof)
- **mako**: deprecated settings.criteria by [@brian14708](https://github.com/brian14708)
- **nixos/gitea**: copy files across for v12 forgejo by [@isabelroses](https://github.com/isabelroses)
- **paws**: use hash instead of narHash by [@isabelroses](https://github.com/isabelroses)
- **pkgs/nvim**: copy overrides from nixpkgs by [@w-lfchen](https://github.com/w-lfchen)
- **pkgs/paws**: set timezone to UTC for fetcher by [@isabelroses](https://github.com/isabelroses)
- **pkgs/rofi**: remove import at build by [@isabelroses](https://github.com/isabelroses)
- **tests**: disable forgejo by [@isabelroses](https://github.com/isabelroses)
- **whiskers**: enable useFetchCargoVendor by [@PerchunPak](https://github.com/PerchunPak)
- **yazi**: update repository source by [@isabelroses](https://github.com/isabelroses)
- use correct nixfmt package by [@getchoo](https://github.com/getchoo)
- assert home-manager version for thunderbird module by [@nim65s](https://github.com/nim65s)
- useFetchCargoVendor is non-optional and enabled by default as of 25.05 by [@Safenein](https://github.com/Safenein)

### ⏪ Reverted

- "fix(home-manager/alacritty): remove the `general` setting option" by [@Yakkhini](https://github.com/Yakkhini)
- "fix(home-manager/lazygit): avoid IFD" by [@getchoo](https://github.com/getchoo)

### 📚 Documentation

- **FAQ**: move to catppuccin namespace by [@42willow](https://github.com/42willow)
- **README**: sync FAQ with site by [@42willow](https://github.com/42willow)
- **README**: link to IFD tracking issue by [@getchoo](https://github.com/getchoo)
- show new option namespace by [@asymmetric](https://github.com/asymmetric)
- update home-manager module name in readme by [@TheJolman](https://github.com/TheJolman)
- move to starlight by [@getchoo](https://github.com/getchoo)
- clean up and add release branch guides by [@getchoo](https://github.com/getchoo)

### New Contributors

* [@HeitorAugustoLN](https://github.com/HeitorAugustoLN) made their first contribution in [#447](https://github.com/catppuccin/nix/issues/447)
* [@MisileLab](https://github.com/MisileLab) made their first contribution in [#553](https://github.com/catppuccin/nix/issues/553)
* [@Safenein](https://github.com/Safenein) made their first contribution in [#629](https://github.com/catppuccin/nix/issues/629)
* [@TheJolman](https://github.com/TheJolman) made their first contribution in [#562](https://github.com/catppuccin/nix/issues/562)
* [@Yakkhini](https://github.com/Yakkhini) made their first contribution in [#452](https://github.com/catppuccin/nix/issues/452)
* [@asymmetric](https://github.com/asymmetric) made their first contribution in [#421](https://github.com/catppuccin/nix/issues/421)
* [@awwpotato](https://github.com/awwpotato) made their first contribution in [#605](https://github.com/catppuccin/nix/issues/605)
* [@brian14708](https://github.com/brian14708) made their first contribution in [#563](https://github.com/catppuccin/nix/issues/563)
* [@different-name](https://github.com/different-name) made their first contribution in [#609](https://github.com/catppuccin/nix/issues/609)
* [@dinckelman](https://github.com/dinckelman) made their first contribution in [#570](https://github.com/catppuccin/nix/issues/570)
* [@fmway](https://github.com/fmway) made their first contribution in [#479](https://github.com/catppuccin/nix/issues/479)
* [@frahz](https://github.com/frahz) made their first contribution in [#567](https://github.com/catppuccin/nix/issues/567)
* [@gepbird](https://github.com/gepbird) made their first contribution in [#616](https://github.com/catppuccin/nix/issues/616)
* [@karitham](https://github.com/karitham) made their first contribution in [#537](https://github.com/catppuccin/nix/issues/537)
* [@khaneliman](https://github.com/khaneliman) made their first contribution in [#543](https://github.com/catppuccin/nix/issues/543)
* [@kittywitch](https://github.com/kittywitch) made their first contribution in [#610](https://github.com/catppuccin/nix/issues/610)
* [@luochen1990](https://github.com/luochen1990) made their first contribution in [#589](https://github.com/catppuccin/nix/issues/589)
* [@mariovagomarzal](https://github.com/mariovagomarzal) made their first contribution in [#454](https://github.com/catppuccin/nix/issues/454)
* [@n194](https://github.com/n194) made their first contribution in [#535](https://github.com/catppuccin/nix/issues/535)
* [@natecox](https://github.com/natecox) made their first contribution in [#446](https://github.com/catppuccin/nix/issues/446)
* [@nim65s](https://github.com/nim65s) made their first contribution in [#489](https://github.com/catppuccin/nix/issues/489)
* [@taranarmo](https://github.com/taranarmo) made their first contribution in [#433](https://github.com/catppuccin/nix/issues/433)
* [@toodeluna](https://github.com/toodeluna) made their first contribution in [#457](https://github.com/catppuccin/nix/issues/457)

## [1.2.1](https://github.com/catppuccin/nix/releases/tag/v1.2.1) - 2024-12-20

### 🐛 Bug Fixes

- **home-manager/zed**: use correct names by [@isabelroses](https://github.com/isabelroses)

## [1.2.0](https://github.com/catppuccin/nix/releases/tag/v1.2.0) - 2024-12-20

This will (hopefully) be the final release before 2.0.0. In preparation for the next major release, our
modules have been moved to a standard `catppuccin` namespace (i.e., `programs.bat.catppuccin.enable` is now
`catppuccin.bat.enable`), but aliases to the old options remain for backwards compatibility. **These will be
removed in 2.0.0**

### 🚀 Features

- **home-manager**: add transparent option for micro by [@henrisota](https://github.com/henrisota)
- **home-manager**: add support for zed-editor by [@isabelroses](https://github.com/isabelroses)
- **modules**: move to catppuccin namespace by [@isabelroses](https://github.com/isabelroses)

### 📚 Documentation

- fully document nix library by [@getchoo](https://github.com/getchoo)

## [1.1.1](https://github.com/catppuccin/nix/releases/tag/v1.1.1) - 2024-12-12

### 🐛 Bug Fixes

- fix eval on 25.05 by [@PerchunPak](https://github.com/PerchunPak)

### 📚 Documentation

- **README**: fix typo `catppucin` -> `catppuccin` by [@42willow](https://github.com/42willow)
- use nuscht search for options by [@getchoo](https://github.com/getchoo)
- add nicer redirects by [@getchoo](https://github.com/getchoo)
- use git-cliff for release changelogs by [@getchoo](https://github.com/getchoo)

## [1.1.0](https://github.com/catppuccin/nix/releases/tag/v1.1.0) - 2024-11-08

### 🚀 Features

- **home-manager**: add support for fuzzel by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: add support for spotify-player by [@w-lfchen](https://github.com/w-lfchen)
- **home-manager**: add support for hyprlock by [@42willow](https://github.com/42willow)
- **home-manager**: add support for freetube by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: add support for obs-studio by [@arminius-smh](https://github.com/arminius-smh)
- **home-manager**: add support for aerc by [@benjamb](https://github.com/benjamb)
- **home-manager**: update yazi for accent support by [@uncenter](https://github.com/uncenter)
- **home-manager/fcitx5**: add accent support by [@arminius-smh](https://github.com/arminius-smh)
- **home-manager/fzf**: add accent support by [@ryanccn](https://github.com/ryanccn)
- **home-manager/mako**: add accent color support by [@SchweGELBin](https://github.com/SchweGELBin)
- **home-manager/mpv**: add support for uosc by [@olifloof](https://github.com/olifloof)
- **nixos**: add support for fcitx5 by [@Zh40Le1ZOOB](https://github.com/Zh40Le1ZOOB)

### 🐛 Bug Fixes

- **home-manager/dunst**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager/foot**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager/gtk**: support all tweaks by [@isabelroses](https://github.com/isabelroses)
- **home-manager/hyprland**: inherit cursor size, unset hyprcursor env vars by [@Weathercold](https://github.com/Weathercold)
- **home-manager/hyprland**: allow merging `sources` option by [@zspher](https://github.com/zspher)
- **home-manager/hyprland**: import accents from file by [@Weathercold](https://github.com/Weathercold)
- **home-manager/k9s**: support darwin without XDG by [@alejandro-angulo](https://github.com/alejandro-angulo)
- **home-manager/kitty**: use new `themeFile` option on 24.11 by [@olifloof](https://github.com/olifloof)
- **home-manager/kvantum**: don't uppercase accents and flavors in override by [@ryand56](https://github.com/ryand56)
- **home-manager/lazygit**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager/lazygit**: support darwin without XDG by [@alejandro-angulo](https://github.com/alejandro-angulo)
- **home-manager/mpv**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager/tofi**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager/zathura**: avoid IFD by [@Anomalocaridid](https://github.com/Anomalocaridid)

### 📚 Documentation

- add IFD FAQ by [@vdbe](https://github.com/vdbe)
- remove kitty from README's IFD FAQ by [@vdbe](https://github.com/vdbe)
- fix invalid link by [@somerand0mcat](https://github.com/somerand0mcat)

### New Contributors

* [@42willow](https://github.com/42willow) made their first contribution in [#330](https://github.com/catppuccin/nix/issues/330)
* [@SchweGELBin](https://github.com/SchweGELBin) made their first contribution in [#323](https://github.com/catppuccin/nix/issues/323)
* [@Zh40Le1ZOOB](https://github.com/Zh40Le1ZOOB) made their first contribution in [#221](https://github.com/catppuccin/nix/issues/221)
* [@alejandro-angulo](https://github.com/alejandro-angulo) made their first contribution in [#311](https://github.com/catppuccin/nix/issues/311)
* [@arminius-smh](https://github.com/arminius-smh) made their first contribution in [#343](https://github.com/catppuccin/nix/issues/343)
* [@benjamb](https://github.com/benjamb) made their first contribution in [#338](https://github.com/catppuccin/nix/issues/338)
* [@ryand56](https://github.com/ryand56) made their first contribution in [#358](https://github.com/catppuccin/nix/issues/358)
* [@somerand0mcat](https://github.com/somerand0mcat) made their first contribution in [#350](https://github.com/catppuccin/nix/issues/350)
* [@w-lfchen](https://github.com/w-lfchen) made their first contribution in [#296](https://github.com/catppuccin/nix/issues/296)

## [1.0.2](https://github.com/catppuccin/nix/releases/tag/v1.0.2) - 2024-07-02

### 🐛 Bug Fixes

- **home-manager/cursors**: exclude from `catppuccin.enable` by [@getchoo](https://github.com/getchoo)

### ⏪ Reverted

- **gtk**: don't replace `normal` tweak with `default` by [@isabelroses](https://github.com/isabelroses)

## [1.0.1](https://github.com/catppuccin/nix/releases/tag/v1.0.1) - 2024-06-30

### 🐛 Bug Fixes

- **home-manager/gtk**: replace `normal` tweak with `default` by [@isabelroses](https://github.com/isabelroses)

### 📚 Documentation

- add v1.0.0 changelog to website by [@getchoo](https://github.com/getchoo)
- symlink site changelog by [@getchoo](https://github.com/getchoo)

## [1.0.0](https://github.com/catppuccin/nix/releases/tag/v1.0.0) - 2024-06-29

### 🚨 Breaking Changes

- **home-manager**: add support for global cursors by [@Weathercold](https://github.com/Weathercold)
- **modules**: auto import modules & improve passing of arguments by [@getchoo](https://github.com/getchoo)
- **modules**: use flavor and accent defaults from org by [@uncenter](https://github.com/uncenter)
- **modules**: flavour -> flavor by [@getchoo](https://github.com/getchoo)
- **modules**: bump minimum supported release to 24.05 by [@getchoo](https://github.com/getchoo)
- switch to NixOS/HM modules by [@Stonks3141](https://github.com/Stonks3141)
- move docs to website by [@getchoo](https://github.com/getchoo)

### 🚀 Features

- **gtk**: add cursor theming support by [@pluiedev](https://github.com/pluiedev)
- **hm**: micro init by [@isabelroses](https://github.com/isabelroses)
- **home-manager**: add starship theme by [@Stonks3141](https://github.com/Stonks3141)
- **home-manager**: add support for kitty by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for alacritty by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for btop by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for tmux by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for sway by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for neovim by [@getchoo](https://github.com/getchoo)
- **home-manager**: add support for fish by [@Scrumplex](https://github.com/Scrumplex)
- **home-manager**: init mako module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init hyprland module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init zathura module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init delta module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init swaylock module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init imv module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: init gitui module
- **home-manager**: init fzf module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: add support for rofi by [@henrisota](https://github.com/henrisota)
- **home-manager**: add support for dunst by [@henrisota](https://github.com/henrisota)
- **home-manager**: init yazi module
- **home-manager**: init k9s module by [@bjw-s](https://github.com/bjw-s)
- **home-manager**: init rio module by [@michaelBelsanti](https://github.com/michaelBelsanti)
- **home-manager**: add support for cava by [@henrisota](https://github.com/henrisota)
- **home-manager**: add support for foot by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: init fcitx5 module by [@pluiedev](https://github.com/pluiedev)
- **home-manager**: allow dark and light accents for gtk cursors by [@PerchunPak](https://github.com/PerchunPak)
- **home-manager**: init mpv module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: add support for skim by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add support for zellij by [@eljamm](https://github.com/eljamm)
- **home-manager**: add transparent option for k9s by [@henrisota](https://github.com/henrisota)
- **home-manager**: add support for tofi by [@henrisota](https://github.com/henrisota)
- **home-manager**: add support for gh-dash by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add support for waybar by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add support for zsh-syntax-highlighting by [@XYenon](https://github.com/XYenon)
- **home-manager**: source hyprland theme and add accent colors by [@Liassica](https://github.com/Liassica)
- **home-manager**: add `extraConfig` option for tmux by [@vdbe](https://github.com/vdbe)
- **home-manager**: add `gnomeShellTheme` option for gtk by [@c-leri](https://github.com/c-leri)
- **home-manager**: add `apply` option for fcitx5 by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add gtk icon theme by [@Weathercold](https://github.com/Weathercold)
- **home-manager**: add support for kvantum by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: add support for cava themes with transparent background by [@AdrienCos](https://github.com/AdrienCos)
- **home-manager**: add support for newsboat by [@Xelden](https://github.com/Xelden)
- **home-manager**: set hyprcursor by [@isabelroses](https://github.com/isabelroses)
- **modules**: add support for helix by [@getchoo](https://github.com/getchoo)
- **modules**: add support for bottom by [@getchoo](https://github.com/getchoo)
- **modules**: add support for polybar by [@getchoo](https://github.com/getchoo)
- **modules**: add util library by [@getchoo](https://github.com/getchoo)
- **modules**: add support for lazygit by [@isabelroses](https://github.com/isabelroses)
- **modules**: add global `enable` option by [@drupol](https://github.com/drupol)
- **modules**: add `catppuccin.sources` option by [@getchoo](https://github.com/getchoo)
- **modules**: support nixos & home-manager's stable branches by [@getchoo](https://github.com/getchoo)
- **modules**: add declarations by [@getchoo](https://github.com/getchoo)
- **modules/home-manager**: add glamour by [@ryanccn](https://github.com/ryanccn)
- **nixos**: add support for grub by [@getchoo](https://github.com/getchoo)
- **nixos**: init console module by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **nixos**: add global `accent` option by [@Weathercold](https://github.com/Weathercold)
- **nixos**: add support for sddm by [@isabelroses](https://github.com/isabelroses)
- **nixos**: add support for plymouth by [@Weathercold](https://github.com/Weathercold)
- add flavour option to nixos module by [@Stonks3141](https://github.com/Stonks3141)
- add flake-compat support by [@getchoo](https://github.com/getchoo)
- add autogenerated docs by [@getchoo](https://github.com/getchoo)
- limit use of IFD, add auto updates & vm testing by [@getchoo](https://github.com/getchoo)
- add subflake for development & testing by [@getchoo](https://github.com/getchoo)

### 🐛 Bug Fixes

- **home-manager**: don't set home.activation.batCache by [@getchoo](https://github.com/getchoo)
- **home-manager**: adopt new naming scheme for gtk theme by [@getchoo](https://github.com/getchoo)
- **home-manager**: capitalize "Light" and "Dark" by [@vgskye](https://github.com/vgskye)
- **home-manager**: dont declare xdg.configFile when btop isn't enabled by [@getchoo](https://github.com/getchoo)
- **home-manager**: correctly set btop's theme by [@Anomalocaridid](https://github.com/Anomalocaridid)
- **home-manager**: apply lazygit theme by [@zspher](https://github.com/zspher)
- **home-manager**: match refactors in bat source by [@ryanccn](https://github.com/ryanccn)
- **home-manager**: use correct name for gtk cursor by [@Hamish-McLean](https://github.com/Hamish-McLean)
- **home-manager**: add file for yazi syntax highlighting by [@michaelBelsanti](https://github.com/michaelBelsanti)
- **home-manager**: link GTK 4.0 files by [@EnzioKam](https://github.com/EnzioKam)
- **home-manager**: allow overriding styles for the rofi theme by [@aloop](https://github.com/aloop)
- **home-manager**: properly enable gtk in vm test by [@getchoo](https://github.com/getchoo)
- **home-manager**: use local flavour option for delta by [@Lichthagel](https://github.com/Lichthagel)
- **home-manager**: make dark/light lowercase for style names in gtk by [@selfuryon](https://github.com/selfuryon)
- **home-manager**: capitalize gtkTheme by [@c-leri](https://github.com/c-leri)
- **home-manager**: remove xdg.enable assertions by [@getchoo](https://github.com/getchoo)
- **home-manager**: gtk cursors are now lowercase by [@isabelroses](https://github.com/isabelroses)
- **home-manager**: use correct gtk theme name by [@eljamm](https://github.com/eljamm)
- **home-manager**: assert `qt.style.name` for kvantum theme by [@getchoo](https://github.com/getchoo)
- **home-manager**: don't let swaylock cause infinite recursion by [@getchoo](https://github.com/getchoo)
- **home-manager**: assert `qt.platformTheme.name` for kvantum by [@olifloof](https://github.com/olifloof)
- **home-manager**: only enable pointerCursor by default on linux by [@XYenon](https://github.com/XYenon)
- **home-manager/bat**: use attrset for theme specification by [@ryanccn](https://github.com/ryanccn)
- **home-manager/sway**: avoid IFD by [@Scrumplex](https://github.com/Scrumplex)
- **modules**: vendor our own revision of nixpkgs by [@getchoo](https://github.com/getchoo)
- **modules**: pass version to mkOptionDoc correctly by [@getchoo](https://github.com/getchoo)
- **modules**: shorten defaultText for `catppuccin.sources` by [@getchoo](https://github.com/getchoo)
- **nixos**: sddm package not being installed by [@Weathercold](https://github.com/Weathercold)
- **nixos**: use the qt 6 version of sddm by [@isabelroses](https://github.com/isabelroses)
- import bat.nix by [@Stonks3141](https://github.com/Stonks3141)
- don’t enable bat by [@Stonks3141](https://github.com/Stonks3141)
- set correct path for modules by [@getchoo](https://github.com/getchoo)

### 📚 Documentation

- fix README header by [@Stonks3141](https://github.com/Stonks3141)
- begin contributing guidelines by [@Stonks3141](https://github.com/Stonks3141)
- fix copyright year in README by [@Stonks3141](https://github.com/Stonks3141)
- complete readme template by [@getchoo](https://github.com/getchoo)
- clean up contributing guidelines by [@Stonks3141](https://github.com/Stonks3141)
- fix info for `revert` commits by [@Stonks3141](https://github.com/Stonks3141)
- add `nixos` and `home-manager` scopes by [@Stonks3141](https://github.com/Stonks3141)
- add link to nixos modules by [@getchoo](https://github.com/getchoo)
- add instructions for maintainers by [@Stonks3141](https://github.com/Stonks3141)
- specify stance on unofficial ports by [@getchoo](https://github.com/getchoo)
- correct use of `modules` over `imports` by [@getchoo](https://github.com/getchoo)
- cleanup CONTRIBUTING.md by [@getchoo](https://github.com/getchoo)
- update link to `catppuccin.enable` by [@getchoo](https://github.com/getchoo)

### New Contributors

* [@AdrienCos](https://github.com/AdrienCos) made their first contribution in [#191](https://github.com/catppuccin/nix/issues/191)
* [@Anomalocaridid](https://github.com/Anomalocaridid) made their first contribution in [#95](https://github.com/catppuccin/nix/issues/95)
* [@EnzioKam](https://github.com/EnzioKam) made their first contribution in [#114](https://github.com/catppuccin/nix/issues/114)
* [@Hamish-McLean](https://github.com/Hamish-McLean) made their first contribution in [#106](https://github.com/catppuccin/nix/issues/106)
* [@Liassica](https://github.com/Liassica) made their first contribution in [#80](https://github.com/catppuccin/nix/issues/80)
* [@Lichthagel](https://github.com/Lichthagel) made their first contribution in [#175](https://github.com/catppuccin/nix/issues/175)
* [@PerchunPak](https://github.com/PerchunPak) made their first contribution in [#116](https://github.com/catppuccin/nix/issues/116)
* [@Scrumplex](https://github.com/Scrumplex) made their first contribution in [#59](https://github.com/catppuccin/nix/issues/59)
* [@Weathercold](https://github.com/Weathercold) made their first contribution in [#195](https://github.com/catppuccin/nix/issues/195)
* [@XYenon](https://github.com/XYenon) made their first contribution in [#248](https://github.com/catppuccin/nix/issues/248)
* [@Xelden](https://github.com/Xelden) made their first contribution in [#217](https://github.com/catppuccin/nix/issues/217)
* [@aloop](https://github.com/aloop) made their first contribution in [#123](https://github.com/catppuccin/nix/issues/123)
* [@bjw-s](https://github.com/bjw-s) made their first contribution in [#110](https://github.com/catppuccin/nix/issues/110)
* [@c-leri](https://github.com/c-leri) made their first contribution in [#161](https://github.com/catppuccin/nix/issues/161)
* [@drupol](https://github.com/drupol) made their first contribution in [#124](https://github.com/catppuccin/nix/issues/124)
* [@eljamm](https://github.com/eljamm) made their first contribution in [#239](https://github.com/catppuccin/nix/issues/239)
* [@getchoo](https://github.com/getchoo) made their first contribution in [#256](https://github.com/catppuccin/nix/issues/256)
* [@henrisota](https://github.com/henrisota) made their first contribution in [#131](https://github.com/catppuccin/nix/issues/131)
* [@isabelroses](https://github.com/isabelroses) made their first contribution in [#230](https://github.com/catppuccin/nix/issues/230)
* [@michaelBelsanti](https://github.com/michaelBelsanti) made their first contribution in [#119](https://github.com/catppuccin/nix/issues/119)
* [@olifloof](https://github.com/olifloof) made their first contribution in [#245](https://github.com/catppuccin/nix/issues/245)
* [@pluiedev](https://github.com/pluiedev) made their first contribution in [#128](https://github.com/catppuccin/nix/issues/128)
* [@ryanccn](https://github.com/ryanccn) made their first contribution in [#91](https://github.com/catppuccin/nix/issues/91)
* [@selfuryon](https://github.com/selfuryon) made their first contribution in [#147](https://github.com/catppuccin/nix/issues/147)
* [@sgoudham](https://github.com/sgoudham) made their first contribution in [#201](https://github.com/catppuccin/nix/issues/201)
* [@uncenter](https://github.com/uncenter) made their first contribution in [#145](https://github.com/catppuccin/nix/issues/145)
* [@vdbe](https://github.com/vdbe) made their first contribution in [#137](https://github.com/catppuccin/nix/issues/137)
* [@vgskye](https://github.com/vgskye) made their first contribution
* [@zspher](https://github.com/zspher) made their first contribution in [#76](https://github.com/catppuccin/nix/issues/76)

<!-- generated by git-cliff -->
