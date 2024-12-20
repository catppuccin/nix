# Changelog

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
