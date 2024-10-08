# Changelog

## [1.1.0](https://github.com/catppuccin/nix/compare/v1.0.2...v1.1.0) (2024-10-08)


### Features

* **home-manager/fzf:** add accent support ([#331](https://github.com/catppuccin/nix/issues/331)) ([45745fe](https://github.com/catppuccin/nix/commit/45745fe5960acaefef2b60f3455bcac6a0ca6bc9))
* **home-manager/mako:** add accent color support ([#323](https://github.com/catppuccin/nix/issues/323)) ([966af28](https://github.com/catppuccin/nix/commit/966af28f2d5b7b5bd3f947d6bab5d7da3bf9fee4))
* **home-manager/mpv:** add support for uosc ([#291](https://github.com/catppuccin/nix/issues/291)) ([8bdb55c](https://github.com/catppuccin/nix/commit/8bdb55cc1c13f572b6e4307a3c0d64f1ae286a4f))
* **home-manager:** add support for aerc ([#338](https://github.com/catppuccin/nix/issues/338)) ([96cf8b4](https://github.com/catppuccin/nix/commit/96cf8b4a05fb23a53c027621b1147b5cf9e5439f))
* **home-manager:** add support for freetube ([#327](https://github.com/catppuccin/nix/issues/327)) ([6effc32](https://github.com/catppuccin/nix/commit/6effc32e614405c05a63a1365fd078a0ab996a0e))
* **home-manager:** add support for fuzzel ([#75](https://github.com/catppuccin/nix/issues/75)) ([7e23de3](https://github.com/catppuccin/nix/commit/7e23de352f519067ea88db869e9aa14222290a73))
* **home-manager:** add support for hyprlock ([#330](https://github.com/catppuccin/nix/issues/330)) ([faea883](https://github.com/catppuccin/nix/commit/faea8838116f5e5fa2ab4b00d97d8d1e0e382bae))
* **home-manager:** add support for obs-studio ([#324](https://github.com/catppuccin/nix/issues/324)) ([76dd2b2](https://github.com/catppuccin/nix/commit/76dd2b2e1f8d1ec7090c30462f8bcc0b7c598389))
* **home-manager:** add support for spotify-player ([#296](https://github.com/catppuccin/nix/issues/296)) ([ff4128f](https://github.com/catppuccin/nix/commit/ff4128f8ea57879050145cf077a27b9d3a9cbf33))


### Bug Fixes

* **home-manager/dunst:** avoid IFD ([#302](https://github.com/catppuccin/nix/issues/302)) ([9fdb8aa](https://github.com/catppuccin/nix/commit/9fdb8aaf65afaa4262ba41bfac1f45c3a7cc36a0))
* **home-manager/foot:** avoid IFD ([#300](https://github.com/catppuccin/nix/issues/300)) ([38df8bf](https://github.com/catppuccin/nix/commit/38df8bf46f0a88e11490de438100207a48040a9c))
* **home-manager/gtk:** support all tweaks ([#274](https://github.com/catppuccin/nix/issues/274)) ([5520567](https://github.com/catppuccin/nix/commit/552056779a136092eb6358c573d925630172fc30))
* **home-manager/hyprland:** allow merging `sources` option ([#309](https://github.com/catppuccin/nix/issues/309)) ([b1e6a8c](https://github.com/catppuccin/nix/commit/b1e6a8cbf12f86f0219a743a1f112ea20c0b2454))
* **home-manager/hyprland:** import accents from file ([#347](https://github.com/catppuccin/nix/issues/347)) ([65f2a8a](https://github.com/catppuccin/nix/commit/65f2a8a36422e54ae469f3fc6325775ce497724b))
* **home-manager/hyprland:** inherit cursor size, unset hyprcursor env vars ([#299](https://github.com/catppuccin/nix/issues/299)) ([512306a](https://github.com/catppuccin/nix/commit/512306ae5848d11a9b38afe4680b69e4908648a2))
* **home-manager/k9s:** support darwin without XDG ([#311](https://github.com/catppuccin/nix/issues/311)) ([0047cf5](https://github.com/catppuccin/nix/commit/0047cf5816313075f5a141daea73532525dbb5df))
* **home-manager/kitty:** use new `themeFile` option on 24.11 ([#337](https://github.com/catppuccin/nix/issues/337)) ([f91de98](https://github.com/catppuccin/nix/commit/f91de989e9671176ee4cda16c4b297d5a9682a45))
* **home-manager/lazygit:** avoid IFD ([#304](https://github.com/catppuccin/nix/issues/304)) ([66f4ea1](https://github.com/catppuccin/nix/commit/66f4ea170093b62f319f41cebd2337a51b225c5a))
* **home-manager/lazygit:** support darwin without XDG ([#313](https://github.com/catppuccin/nix/issues/313)) ([8886a68](https://github.com/catppuccin/nix/commit/8886a68edadb1d93c7101337f995ffce4b410ff2))
* **home-manager/mpv:** avoid IFD ([#303](https://github.com/catppuccin/nix/issues/303)) ([f1ccaad](https://github.com/catppuccin/nix/commit/f1ccaad444ef97c84c59215e3858ed7a95fa7bff))
* **home-manager/tofi:** avoid IFD ([#301](https://github.com/catppuccin/nix/issues/301)) ([afe2c4c](https://github.com/catppuccin/nix/commit/afe2c4c8651c137c44ec45c5e01948979cb77bc7))
* **home-manager/zathura:** avoid IFD ([#298](https://github.com/catppuccin/nix/issues/298)) ([41d51d7](https://github.com/catppuccin/nix/commit/41d51d7f0459f95ab354b81ecbd49cc413a8d49d))

## [1.0.2](https://github.com/catppuccin/nix/compare/v1.0.1...v1.0.2) (2024-07-02)


### Bug Fixes

* **home-manager/cursors:** exclude from `catppuccin.enable` ([#263](https://github.com/catppuccin/nix/issues/263)) ([9eb0610](https://github.com/catppuccin/nix/commit/9eb0610d48dd0e1fecf772bbdacf9050d7b82d7c))


### Reverts

* **gtk:** don't replace `normal` tweak with `default` ([#271](https://github.com/catppuccin/nix/issues/271)) ([7bfda77](https://github.com/catppuccin/nix/commit/7bfda77cd1c65a221edfc412051fab9c95102123))

## [1.0.1](https://github.com/catppuccin/nix/compare/v1.0.0...v1.0.1) (2024-06-30)


### Bug Fixes

* **home-manager/gtk:** replace `normal` tweak with `default` ([#261](https://github.com/catppuccin/nix/issues/261)) ([92e2d7a](https://github.com/catppuccin/nix/commit/92e2d7ae880cd77677be66af2e77b2bc6b74f4fa))

## 1.0.0 (2024-06-29)


### ⚠ BREAKING CHANGES

* **home-manager:** add support for global cursors ([#195](https://github.com/catppuccin/nix/issues/195))
* **modules:** bump minimum supported release to 24.05 ([#203](https://github.com/catppuccin/nix/issues/203))
* **modules:** flavour -> flavor ([#190](https://github.com/catppuccin/nix/issues/190))
* move docs to website ([#170](https://github.com/catppuccin/nix/issues/170))
* **modules:** use flavor and accent defaults from org ([#145](https://github.com/catppuccin/nix/issues/145))
* **modules:** auto import modules & improve passing of arguments ([#60](https://github.com/catppuccin/nix/issues/60))
* switch to NixOS/HM modules

### Features

* add autogenerated docs ([#39](https://github.com/catppuccin/nix/issues/39)) ([a60d227](https://github.com/catppuccin/nix/commit/a60d2276228066c597cfb8e6d40053281958ab59))
* add flake-compat support ([359e24d](https://github.com/catppuccin/nix/commit/359e24de7d4112e53c1130a3061112e31fbf7b4e))
* add flavour option to nixos module ([13e5ba5](https://github.com/catppuccin/nix/commit/13e5ba50206c2d709a91cac5106086597dcaabe2))
* add subflake for development & testing ([#64](https://github.com/catppuccin/nix/issues/64)) ([07e54f5](https://github.com/catppuccin/nix/commit/07e54f5b3c84885d2fef13e6959117aa29346322))
* **gtk:** add cursor theming support ([#61](https://github.com/catppuccin/nix/issues/61)) ([f3aaec1](https://github.com/catppuccin/nix/commit/f3aaec142f9b9182cbeaf19b3431574b00817173))
* **hm:** micro init ([#47](https://github.com/catppuccin/nix/issues/47)) ([71f4a7d](https://github.com/catppuccin/nix/commit/71f4a7d6ffef709c6d4e8d8f229b0f6ac583f0a0))
* **home-manager:** add `apply` option for fcitx5 ([#144](https://github.com/catppuccin/nix/issues/144)) ([7bf0166](https://github.com/catppuccin/nix/commit/7bf0166443903a7626e6aa2411a11e866bb3793e))
* **home-manager:** add `extraConfig` option for tmux ([#137](https://github.com/catppuccin/nix/issues/137)) ([2429fdc](https://github.com/catppuccin/nix/commit/2429fdcd672c0958514a85bf024d45af7cb93b92))
* **home-manager:** add `gnomeShellTheme` option for gtk ([#161](https://github.com/catppuccin/nix/issues/161)) ([5e0f749](https://github.com/catppuccin/nix/commit/5e0f749a08bd6b4af2165976c1e3e0c8db5fc74e))
* **home-manager:** add gtk icon theme ([#165](https://github.com/catppuccin/nix/issues/165)) ([27e71a3](https://github.com/catppuccin/nix/commit/27e71a35480db654a75696059e169d3e0e029eb4))
* **home-manager:** add starship theme ([fa2b78a](https://github.com/catppuccin/nix/commit/fa2b78afa3fa49f9d7598007a39f8843ffac04af))
* **home-manager:** add support for alacritty ([#22](https://github.com/catppuccin/nix/issues/22)) ([c5eeae7](https://github.com/catppuccin/nix/commit/c5eeae703f20176a421fde57e76842cc4f4c453d))
* **home-manager:** add support for btop ([#20](https://github.com/catppuccin/nix/issues/20)) ([25edfe9](https://github.com/catppuccin/nix/commit/25edfe9641184ef8b53ca3f69c28433e784fa4e1))
* **home-manager:** add support for cava ([#121](https://github.com/catppuccin/nix/issues/121)) ([04fc060](https://github.com/catppuccin/nix/commit/04fc0602347a43fbbd3c95fa13ec2765bb82ec3b))
* **home-manager:** add support for cava themes with transparent background ([#191](https://github.com/catppuccin/nix/issues/191)) ([ba40680](https://github.com/catppuccin/nix/commit/ba40680357bca0f04f8518ff22349ad89941d81e))
* **home-manager:** add support for dunst ([#104](https://github.com/catppuccin/nix/issues/104)) ([9e71751](https://github.com/catppuccin/nix/commit/9e71751d6676cdf10ba2be93039bee9413ca36d7))
* **home-manager:** add support for fish ([#46](https://github.com/catppuccin/nix/issues/46)) ([5713b47](https://github.com/catppuccin/nix/commit/5713b478b10c5ef703fd921d96ca6a3057c457b5))
* **home-manager:** add support for foot ([#120](https://github.com/catppuccin/nix/issues/120)) ([5e09f8a](https://github.com/catppuccin/nix/commit/5e09f8a293808c456045b8a33413a05ee6289b94))
* **home-manager:** add support for gh-dash ([#143](https://github.com/catppuccin/nix/issues/143)) ([78a000d](https://github.com/catppuccin/nix/commit/78a000d06c975d0c9214c65da1957113f71f33c1))
* **home-manager:** add support for global cursors ([#195](https://github.com/catppuccin/nix/issues/195)) ([6e77fdd](https://github.com/catppuccin/nix/commit/6e77fdd91d4d92e3e984306458dd14502d91ca60))
* **home-manager:** add support for kitty ([#19](https://github.com/catppuccin/nix/issues/19)) ([bdc4336](https://github.com/catppuccin/nix/commit/bdc4336b37a1c261307fab6e349c816249c43abe))
* **home-manager:** add support for kvantum ([#175](https://github.com/catppuccin/nix/issues/175)) ([f32e5ab](https://github.com/catppuccin/nix/commit/f32e5ab2b541b22893cf1ddb2df576d43c9923ba))
* **home-manager:** add support for neovim ([#27](https://github.com/catppuccin/nix/issues/27)) ([20a4a5d](https://github.com/catppuccin/nix/commit/20a4a5d3f29a18154514ef6af319bb084cbd5d18))
* **home-manager:** add support for newsboat ([#217](https://github.com/catppuccin/nix/issues/217)) ([85558d1](https://github.com/catppuccin/nix/commit/85558d1638a65ed1cc7fb8bd7cfc1a5474b21fdb))
* **home-manager:** add support for rofi ([#108](https://github.com/catppuccin/nix/issues/108)) ([56f3c60](https://github.com/catppuccin/nix/commit/56f3c604a80ca8efe37b7ffb7e09d384c464bfa7))
* **home-manager:** add support for skim ([#132](https://github.com/catppuccin/nix/issues/132)) ([bcec389](https://github.com/catppuccin/nix/commit/bcec389351ade7e78cd1fe428a156cd6490b3458))
* **home-manager:** add support for sway ([#26](https://github.com/catppuccin/nix/issues/26)) ([12733d6](https://github.com/catppuccin/nix/commit/12733d64c3c5e79d777dff3f0f908ab0e39f7082))
* **home-manager:** add support for tmux ([#21](https://github.com/catppuccin/nix/issues/21)) ([8f93009](https://github.com/catppuccin/nix/commit/8f930092e54438b5a1bea1126966926a4ff06500))
* **home-manager:** add support for tofi ([#131](https://github.com/catppuccin/nix/issues/131)) ([0260166](https://github.com/catppuccin/nix/commit/02601660436ef33a907178420cb35fffa27c66d8))
* **home-manager:** add support for waybar ([#133](https://github.com/catppuccin/nix/issues/133)) ([2788bec](https://github.com/catppuccin/nix/commit/2788becbb58bd2a60666fbbf2d4f6ae1721112d5))
* **home-manager:** add support for zellij ([#139](https://github.com/catppuccin/nix/issues/139)) ([a5d452a](https://github.com/catppuccin/nix/commit/a5d452a200dbc9844a0305237d1b799ee08be024))
* **home-manager:** add support for zsh-syntax-highlighting ([#146](https://github.com/catppuccin/nix/issues/146)) ([ef2f0d9](https://github.com/catppuccin/nix/commit/ef2f0d91ea4c8981276136f7f114f9dcb4858ba1))
* **home-manager:** add transparent option for k9s ([#138](https://github.com/catppuccin/nix/issues/138)) ([ade2e73](https://github.com/catppuccin/nix/commit/ade2e737d6b8157f4c426ae7299dc78356c5bc92))
* **home-manager:** allow dark and light accents for gtk cursors ([#116](https://github.com/catppuccin/nix/issues/116)) ([4f5d429](https://github.com/catppuccin/nix/commit/4f5d42994c7c295b3833db1de6210196b2c586d8))
* **home-manager:** init delta module ([#82](https://github.com/catppuccin/nix/issues/82)) ([a3e55e6](https://github.com/catppuccin/nix/commit/a3e55e6533a7a815788e24d3d8b1bf6f85d5b592))
* **home-manager:** init fcitx5 module ([#128](https://github.com/catppuccin/nix/issues/128)) ([b35a034](https://github.com/catppuccin/nix/commit/b35a03410d6034d32a7576d240d1347e2241c79d))
* **home-manager:** init fzf module ([#93](https://github.com/catppuccin/nix/issues/93)) ([b08e480](https://github.com/catppuccin/nix/commit/b08e4805e37d37892e70218d70370bc84d4f27f4))
* **home-manager:** init gitui module ([#98](https://github.com/catppuccin/nix/issues/98)) ([19256c4](https://github.com/catppuccin/nix/commit/19256c4539b26074301cc1e28ee4844cd7e54ac1))
* **home-manager:** init hyprland module ([#56](https://github.com/catppuccin/nix/issues/56)) ([88376af](https://github.com/catppuccin/nix/commit/88376af32e22a916ccd49adfef8615fec3e00eac))
* **home-manager:** init imv module ([#94](https://github.com/catppuccin/nix/issues/94)) ([92034aa](https://github.com/catppuccin/nix/commit/92034aab312607e818ff66f4572f7085994498d7))
* **home-manager:** init k9s module ([#110](https://github.com/catppuccin/nix/issues/110)) ([ef464d6](https://github.com/catppuccin/nix/commit/ef464d6dedebda5c9a96db2e451c86f813e7c868))
* **home-manager:** init mako module ([#49](https://github.com/catppuccin/nix/issues/49)) ([4840eda](https://github.com/catppuccin/nix/commit/4840eda13e86a940d7c9a08e739629ee20aa95c2))
* **home-manager:** init mpv module ([#95](https://github.com/catppuccin/nix/issues/95)) ([f9d03f8](https://github.com/catppuccin/nix/commit/f9d03f81f912db993555709ace3f440f3139b36a))
* **home-manager:** init rio module ([#100](https://github.com/catppuccin/nix/issues/100)) ([453cca1](https://github.com/catppuccin/nix/commit/453cca1f229d63728d2c49adec08bd80d08251f1))
* **home-manager:** init swaylock module ([#92](https://github.com/catppuccin/nix/issues/92)) ([6ab5126](https://github.com/catppuccin/nix/commit/6ab5126dbe51e4967ff19cf6b916c32f24cdb172))
* **home-manager:** init yazi module ([#101](https://github.com/catppuccin/nix/issues/101)) ([9307549](https://github.com/catppuccin/nix/commit/930754919d6bc5ac87e5091a317e674e6290e85f))
* **home-manager:** init zathura module ([#53](https://github.com/catppuccin/nix/issues/53)) ([4ba874e](https://github.com/catppuccin/nix/commit/4ba874eaa973c4266994ccba4992ef5fee91bef7))
* **home-manager:** set hyprcursor ([#218](https://github.com/catppuccin/nix/issues/218)) ([e55fb42](https://github.com/catppuccin/nix/commit/e55fb4262b17f702624bcbb58531a2b84a69a94e))
* **home-manager:** source hyprland theme and add accent colors ([#80](https://github.com/catppuccin/nix/issues/80)) ([cab752b](https://github.com/catppuccin/nix/commit/cab752b0f04145f426181ee59f99c53a19e20139))
* initial commit ([fad8bd6](https://github.com/catppuccin/nix/commit/fad8bd63ef3daa02886613623d46d72dc77b0be7))
* limit use of IFD, add auto updates & vm testing ([#40](https://github.com/catppuccin/nix/issues/40)) ([a30f0ff](https://github.com/catppuccin/nix/commit/a30f0ff077a5fc3739c4630b6cc128d7296a8fc6))
* **modules/home-manager:** add glamour ([#44](https://github.com/catppuccin/nix/issues/44)) ([a97085d](https://github.com/catppuccin/nix/commit/a97085d28b9e4b92f08dccf83087e5133dfbc079))
* **modules:** add `catppuccin.sources` option ([#129](https://github.com/catppuccin/nix/issues/129)) ([28e6d8a](https://github.com/catppuccin/nix/commit/28e6d8a18da22aa5b2cd97904780ecf5cc9a4294))
* **modules:** add declarations ([#198](https://github.com/catppuccin/nix/issues/198)) ([296adaf](https://github.com/catppuccin/nix/commit/296adaf9331cd2c1eb479a25d5207508fbd06188))
* **modules:** add global `enable` option ([#124](https://github.com/catppuccin/nix/issues/124)) ([e45a44e](https://github.com/catppuccin/nix/commit/e45a44e26e9a9b15525a67d782e2d3c1ca04dff8))
* **modules:** add support for bottom ([99216b8](https://github.com/catppuccin/nix/commit/99216b897b261e1fb509a55d8c872c6adc63463f))
* **modules:** add support for helix ([#8](https://github.com/catppuccin/nix/issues/8)) ([298605b](https://github.com/catppuccin/nix/commit/298605b31eebb38e73a9bc5685b28ce1d318b2c8))
* **modules:** add support for lazygit ([547ba19](https://github.com/catppuccin/nix/commit/547ba1984cf53ec7be5c7096fc34f34a64801a67))
* **modules:** add support for polybar ([38fa66c](https://github.com/catppuccin/nix/commit/38fa66cba9a87fac84ce5d0999d9004c4ef5fe5d))
* **modules:** add util library ([#25](https://github.com/catppuccin/nix/issues/25)) ([be6320c](https://github.com/catppuccin/nix/commit/be6320c4b16bc9ee8ee3e81e07bb7257ebef9063))
* **modules:** bump minimum supported release to 24.05 ([#203](https://github.com/catppuccin/nix/issues/203)) ([dc9553e](https://github.com/catppuccin/nix/commit/dc9553ef0b3439f31a9ab5772356bf936895df74))
* **modules:** flavour -&gt; flavor ([#190](https://github.com/catppuccin/nix/issues/190)) ([fea5242](https://github.com/catppuccin/nix/commit/fea5242c0eacc5efa81be0e36206a62e889dbd82))
* **modules:** support nixos & home-manager's stable branches ([#182](https://github.com/catppuccin/nix/issues/182)) ([aef5672](https://github.com/catppuccin/nix/commit/aef567291242b03e141ba68375c2ff75ea8ff676))
* move docs to website ([#170](https://github.com/catppuccin/nix/issues/170)) ([1f11b0a](https://github.com/catppuccin/nix/commit/1f11b0aeb0a321e427f491aa2c5270daf0b13c1f))
* **nixos:** add global `accent` option ([#164](https://github.com/catppuccin/nix/issues/164)) ([8d3e50a](https://github.com/catppuccin/nix/commit/8d3e50a6774582d3d6c3f09e1421c01ead9b2d8e)), closes [#134](https://github.com/catppuccin/nix/issues/134)
* **nixos:** add support for grub ([8b7aa60](https://github.com/catppuccin/nix/commit/8b7aa60e3f0b98c9c90d124411df436a84eb65bb))
* **nixos:** add support for plymouth ([#166](https://github.com/catppuccin/nix/issues/166)) ([9ffc6b8](https://github.com/catppuccin/nix/commit/9ffc6b8c26a7b22899d62d406f9ef90b6de830b5))
* **nixos:** add support for sddm ([#168](https://github.com/catppuccin/nix/issues/168)) ([d8a6d8a](https://github.com/catppuccin/nix/commit/d8a6d8a146d2fe4a63eaa57fff3cb2fd8b044594))
* **nixos:** init console module ([#69](https://github.com/catppuccin/nix/issues/69)) ([18419d5](https://github.com/catppuccin/nix/commit/18419d5a1153a87efa24834879fc54a5b3b27c5f))
* switch to NixOS/HM modules ([78b67b4](https://github.com/catppuccin/nix/commit/78b67b490d763c7d54556215ab57bafa5793b3cc))


### Bug Fixes

* don’t enable bat ([8c3f98e](https://github.com/catppuccin/nix/commit/8c3f98e64c7fedb3114df7ba4000700215e2968c))
* **home-manager/bat:** use attrset for theme specification ([#43](https://github.com/catppuccin/nix/issues/43)) ([4ade204](https://github.com/catppuccin/nix/commit/4ade2040125e692e90204a073a07a6c7f3063ded))
* **home-manager/sway:** avoid IFD ([#45](https://github.com/catppuccin/nix/issues/45)) ([7513e5e](https://github.com/catppuccin/nix/commit/7513e5edf8c2ab2485260049ce8c03ac9f6ca2f7))
* **home-manager:** add file for yazi syntax highlighting ([#119](https://github.com/catppuccin/nix/issues/119)) ([e69bd64](https://github.com/catppuccin/nix/commit/e69bd64bac2ec01fbecf01078e010a433676d4b0))
* **home-manager:** adopt new naming scheme for gtk theme ([#34](https://github.com/catppuccin/nix/issues/34)) ([af61ea4](https://github.com/catppuccin/nix/commit/af61ea49d04afbe33c3dcd51b9590e10c1f26378))
* **home-manager:** allow overriding styles for the rofi theme ([#123](https://github.com/catppuccin/nix/issues/123)) ([7566389](https://github.com/catppuccin/nix/commit/75663896d0c16cd59d567f21f091b1c9338d7118))
* **home-manager:** apply lazygit theme ([#76](https://github.com/catppuccin/nix/issues/76)) ([d4c0e28](https://github.com/catppuccin/nix/commit/d4c0e280e4cb4950c3ec6593db6c472931e937d5))
* **home-manager:** assert `qt.platformTheme.name` for kvantum ([#244](https://github.com/catppuccin/nix/issues/244)) ([e02aca9](https://github.com/catppuccin/nix/commit/e02aca950fba2843083264832473e5856541cb08))
* **home-manager:** assert `qt.style.name` for kvantum theme ([#242](https://github.com/catppuccin/nix/issues/242)) ([1adbfeb](https://github.com/catppuccin/nix/commit/1adbfeb44a54be0ae79eca751ba948a6faa3bb0f))
* **home-manager:** capitalize "Light" and "Dark" ([4302239](https://github.com/catppuccin/nix/commit/430223932eaf0c3b0fbd578f591fc02f6b17fd29))
* **home-manager:** capitalize gtkTheme ([#159](https://github.com/catppuccin/nix/issues/159)) ([360c974](https://github.com/catppuccin/nix/commit/360c974143bc66cfd7ecfef1a12c4e5e9bf95538))
* **home-manager:** correctly set btop's theme ([#48](https://github.com/catppuccin/nix/issues/48)) ([3a12806](https://github.com/catppuccin/nix/commit/3a12806a377fd146a5784b3c004b5b06513b8fb5))
* **home-manager:** don't let swaylock cause infinite recursion ([#243](https://github.com/catppuccin/nix/issues/243)) ([de0dec4](https://github.com/catppuccin/nix/commit/de0dec4cecc580c56127e5da2ced0f6d663cc510))
* **home-manager:** don't set home.activation.batCache ([66ae727](https://github.com/catppuccin/nix/commit/66ae7277106f544eab1e6d23fe2244bc4b731dcc))
* **home-manager:** dont declare xdg.configFile when btop isn't enabled ([#37](https://github.com/catppuccin/nix/issues/37)) ([9616836](https://github.com/catppuccin/nix/commit/9616836d656f34178e2adac1bc2af95ad3952e50))
* **home-manager:** gtk cursors are now lowercase ([#212](https://github.com/catppuccin/nix/issues/212)) ([6336fb8](https://github.com/catppuccin/nix/commit/6336fb8ba1d33498869980ba6b8ce44b25eddf91))
* **home-manager:** link GTK 4.0 files ([#114](https://github.com/catppuccin/nix/issues/114)) ([4b98726](https://github.com/catppuccin/nix/commit/4b98726102678d880c4f7097bc55d8fc1df3f594))
* **home-manager:** make dark/light lowecase for style names in gtk ([#147](https://github.com/catppuccin/nix/issues/147)) ([1fbdfda](https://github.com/catppuccin/nix/commit/1fbdfdacf96c14449aea52edba895e5ab419dd13))
* **home-manager:** match refactors in bat source ([#91](https://github.com/catppuccin/nix/issues/91)) ([03b95ca](https://github.com/catppuccin/nix/commit/03b95cad3bbeb9913db6d89dc3f4fccc6c8fcbd4))
* **home-manager:** only enable pointerCursor by default on linux ([#248](https://github.com/catppuccin/nix/issues/248)) ([63e0859](https://github.com/catppuccin/nix/commit/63e0859743908a53e58b3ceeca06a145a45c4435))
* **home-manager:** properly enable gtk in vm test ([29bd8a3](https://github.com/catppuccin/nix/commit/29bd8a3bda02434bf6ee3edf9ea6edd360a9ce17))
* **home-manager:** remove xdg.enable assertions ([#181](https://github.com/catppuccin/nix/issues/181)) ([1f19ce7](https://github.com/catppuccin/nix/commit/1f19ce7a912dd22f038ba3103c2c0615c330f577))
* **home-manager:** use correct gtk theme name ([#239](https://github.com/catppuccin/nix/issues/239)) ([2fb16f2](https://github.com/catppuccin/nix/commit/2fb16f2d6ffb2759f14fbcbd1f1e242f5fb662c7))
* **home-manager:** use correct name for gtk cursor ([#106](https://github.com/catppuccin/nix/issues/106)) ([852f9c7](https://github.com/catppuccin/nix/commit/852f9c7ddadf5197e286cb3d128d0e498af8913a))
* **home-manager:** use local flavour option for delta ([#150](https://github.com/catppuccin/nix/issues/150)) ([e0fa29f](https://github.com/catppuccin/nix/commit/e0fa29f9f79cdbb5083327705347030142333b56))
* import bat.nix ([f79d1ec](https://github.com/catppuccin/nix/commit/f79d1ecee99d867dcad6e2a4450db0265338cf00))
* **modules:** pass version to mkOptionDoc correctly ([#153](https://github.com/catppuccin/nix/issues/153)) ([f46dffa](https://github.com/catppuccin/nix/commit/f46dffa3345aba8b315ed7ddd1be4bc12f9e9e78))
* **modules:** shorten defaultText for `catppuccin.sources` ([#185](https://github.com/catppuccin/nix/issues/185)) ([8179a45](https://github.com/catppuccin/nix/commit/8179a45f64c7448185eddcacaa81dce080cc45c2))
* **modules:** vendor our own revision of nixpkgs ([c88242c](https://github.com/catppuccin/nix/commit/c88242c4fa240ddd5bb9c38dccd4d48cd142f511))
* **nixos:** sddm package not being installed  ([#194](https://github.com/catppuccin/nix/issues/194)) ([144b70d](https://github.com/catppuccin/nix/commit/144b70d50e95e900b29e60c4f64256f8cf29313d))
* **nixos:** use the qt 6 version of sddm ([#230](https://github.com/catppuccin/nix/issues/230)) ([b6c8545](https://github.com/catppuccin/nix/commit/b6c854508d8c03f3ff06bf658d12b0ae8052d7a5))
* set correct path for modules ([f3adc02](https://github.com/catppuccin/nix/commit/f3adc020b5e340cd34df5804b47a6260d5940700))


### Miscellaneous Chores

* **modules:** use flavor and accent defaults from org ([#145](https://github.com/catppuccin/nix/issues/145)) ([3d3db41](https://github.com/catppuccin/nix/commit/3d3db414f3eae3dd10ab6bcbc71f632aa7ac1b5d))


### Code Refactoring

* **modules:** auto import modules & improve passing of arguments ([#60](https://github.com/catppuccin/nix/issues/60)) ([714c415](https://github.com/catppuccin/nix/commit/714c4155063279d457b4d0ab15144d3cda15bbf1))
