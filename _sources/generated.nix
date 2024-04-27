# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alacritty = {
    pname = "alacritty";
    version = "94800165c13998b600a9da9d29c330de9f28618e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "94800165c13998b600a9da9d29c330de9f28618e";
      fetchSubmodules = false;
      sha256 = "sha256-Pi1Hicv3wPALGgqurdTzXEzJNx7vVh+8B9tlqhRpR2Y=";
    };
    date = "2024-04-09";
  };
  bat = {
    pname = "bat";
    version = "b8134f01b0ac176f1cf2a7043a5abf5a1a29457b";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "b8134f01b0ac176f1cf2a7043a5abf5a1a29457b";
      fetchSubmodules = false;
      sha256 = "sha256-gzf0/Ltw8mGMsEFBTUuN33MSFtUP4xhdxfoZFntaycQ=";
    };
    date = "2024-04-09";
  };
  bottom = {
    pname = "bottom";
    version = "c0efe9025f62f618a407999d89b04a231ba99c92";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "bottom";
      rev = "c0efe9025f62f618a407999d89b04a231ba99c92";
      fetchSubmodules = false;
      sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
    };
    date = "2022-12-30";
  };
  btop = {
    pname = "btop";
    version = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
      fetchSubmodules = false;
      sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
    };
    date = "2023-10-07";
  };
  cava = {
    pname = "cava";
    version = "56c1e69318856a853b28e3ccce500c00099dc051";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "cava";
      rev = "56c1e69318856a853b28e3ccce500c00099dc051";
      fetchSubmodules = false;
      sha256 = "sha256-FNNEYFurT6Y6rkKrvyAGt+3a+7GO4UE5el2sJ2ZKX2k=";
    };
    date = "2024-04-01";
  };
  delta = {
    pname = "delta";
    version = "765eb17d0268bf07c20ca439771153f8bc79444f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "delta";
      rev = "765eb17d0268bf07c20ca439771153f8bc79444f";
      fetchSubmodules = false;
      sha256 = "sha256-GA0n9obZlD0Y2rAbGMjcdJ5I0ij1NEPBFC7rv7J49QI=";
    };
    date = "2024-03-23";
  };
  dunst = {
    pname = "dunst";
    version = "bfec91a5d0ab02a73a4615243feb5499d376831c";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "dunst";
      rev = "bfec91a5d0ab02a73a4615243feb5499d376831c";
      fetchSubmodules = false;
      sha256 = "sha256-xy99DpBrOKlP7DgKyPgbl4QGC+dnXnvkGlkIG0cmd2A=";
    };
    date = "2024-04-07";
  };
  fcitx5 = {
    pname = "fcitx5";
    version = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "fcitx5";
      rev = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
      fetchSubmodules = false;
      sha256 = "sha256-uFaCbyrEjv4oiKUzLVFzw+UY54/h7wh2cntqeyYwGps=";
    };
    date = "2022-10-05";
  };
  fish = {
    pname = "fish";
    version = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "fish";
      rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
      fetchSubmodules = false;
      sha256 = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
    };
    date = "2023-11-02";
  };
  foot = {
    pname = "foot";
    version = "ee5549af72ab78520ac2aa1c671bf5c2d347c8ca";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "foot";
      rev = "ee5549af72ab78520ac2aa1c671bf5c2d347c8ca";
      fetchSubmodules = false;
      sha256 = "sha256-3hK9klXwdHhprG2wUMt7nBfbL1mb/gl+k/MtJUuY000=";
    };
    date = "2024-01-18";
  };
  gh-dash = {
    pname = "gh-dash";
    version = "cb9fea0b86c300b26f1211079d656d02a7eb2c62";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gh-dash";
      rev = "cb9fea0b86c300b26f1211079d656d02a7eb2c62";
      fetchSubmodules = false;
      sha256 = "sha256-IpEkLKXCs7H0SH4UDZy9JMcNQPEg/50f/5SlezdnL80=";
    };
    date = "2024-04-27";
  };
  gitui = {
    pname = "gitui";
    version = "39978362b2c88b636cacd55b65d2f05c45a47eb9";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gitui";
      rev = "39978362b2c88b636cacd55b65d2f05c45a47eb9";
      fetchSubmodules = false;
      sha256 = "sha256-kWaHQ1+uoasT8zXxOxkur+QgZu1wLsOOrP/TL+6cfII=";
    };
    date = "2023-11-13";
  };
  glamour = {
    pname = "glamour";
    version = "66d7b09325af67b1c5cdb063343e829c04ad7d5f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "glamour";
      rev = "66d7b09325af67b1c5cdb063343e829c04ad7d5f";
      fetchSubmodules = false;
      sha256 = "sha256-f3JFgqL3K/u8U/UzmBohJLDBPlT446bosRQDca9+4oA=";
    };
    date = "2024-04-02";
  };
  grub = {
    pname = "grub";
    version = "88f6124757331fd3a37c8a69473021389b7663ad";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "grub";
      rev = "88f6124757331fd3a37c8a69473021389b7663ad";
      fetchSubmodules = false;
      sha256 = "sha256-e8XFWebd/GyX44WQI06Cx6sOduCZc5z7/YhweVQGMGY=";
    };
    date = "2024-03-07";
  };
  gtk = {
    pname = "gtk";
    version = "9da440ced621d1bff58676efdcec9f64284c52a6";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "gtk";
      rev = "9da440ced621d1bff58676efdcec9f64284c52a6";
      fetchSubmodules = false;
      sha256 = "sha256-pGL8vaE63ss2ZT2FoNDfDkeuCxjcbl02RmwwfHC/Vxg=";
    };
    date = "2024-04-20";
  };
  helix = {
    pname = "helix";
    version = "0164c4ca888084df4f511da22c6a0a664b5061d2";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "helix";
      rev = "0164c4ca888084df4f511da22c6a0a664b5061d2";
      fetchSubmodules = false;
      sha256 = "sha256-8d+cGlyW0vurrww0vPETCr077JHibUQTpnTUOLjeObs=";
    };
    date = "2024-03-30";
  };
  hyprland = {
    pname = "hyprland";
    version = "b57375545f5da1f7790341905d1049b1873a8bb3";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "hyprland";
      rev = "b57375545f5da1f7790341905d1049b1873a8bb3";
      fetchSubmodules = false;
      sha256 = "sha256-XTqpmucOeHUgSpXQ0XzbggBFW+ZloRD/3mFhI+Tq4O8=";
    };
    date = "2024-04-03";
  };
  imv = {
    pname = "imv";
    version = "0317a097b6ec8122b1da6d02f61d0c5158019f6e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "imv";
      rev = "0317a097b6ec8122b1da6d02f61d0c5158019f6e";
      fetchSubmodules = false;
      sha256 = "sha256-n6obxM5iVSOdlGdI8ZEmYuxudarLoZHqGETrpTcdrok=";
    };
    date = "2024-01-17";
  };
  k9s = {
    pname = "k9s";
    version = "82eba6feb442932e28facedfb18dfbe79234f180";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "k9s";
      rev = "82eba6feb442932e28facedfb18dfbe79234f180";
      fetchSubmodules = false;
      sha256 = "sha256-VLi7G6Rjmbr6feSOg8aLYJmOb+GyJUKi3k9qod6ut9k=";
    };
    date = "2024-03-22";
  };
  kitty = {
    pname = "kitty";
    version = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
      fetchSubmodules = false;
      sha256 = "sha256-mRFa+40fuJCUrR1o4zMi7AlgjRtFmii4fNsQyD8hIjM=";
    };
    date = "2024-01-10";
  };
  lazygit = {
    pname = "lazygit";
    version = "30bff2e6d14ca12a09d71e5ce4e6a086b3e48aa6";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "lazygit";
      rev = "30bff2e6d14ca12a09d71e5ce4e6a086b3e48aa6";
      fetchSubmodules = false;
      sha256 = "sha256-mmNA7MpORvdCb37myo2QqagPK46rxRxD0dvUMsHegEM=";
    };
    date = "2024-03-31";
  };
  mako = {
    pname = "mako";
    version = "9dd088aa5f4529a3dd4d9760415e340664cb86df";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "mako";
      rev = "9dd088aa5f4529a3dd4d9760415e340664cb86df";
      fetchSubmodules = false;
      sha256 = "sha256-nUzWkQVsIH4rrCFSP87mXAka6P+Td2ifNbTuP7NM/SQ=";
    };
    date = "2023-08-12";
  };
  micro = {
    pname = "micro";
    version = "ed8ef015f97c357575b5013e18042c9faa6c068a";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "micro";
      rev = "ed8ef015f97c357575b5013e18042c9faa6c068a";
      fetchSubmodules = false;
      sha256 = "sha256-/JwZ+5bLYjZWcV5vH22daLqVWbyJelqRyGa7V0b7EG8=";
    };
    date = "2022-09-27";
  };
  mpv = {
    pname = "mpv";
    version = "db31f00b5107320f8882eb8c727060d5eab702c9";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "mpv";
      rev = "db31f00b5107320f8882eb8c727060d5eab702c9";
      fetchSubmodules = false;
      sha256 = "sha256-QxPUjd2Y4FpvEg2aYrKkJVkLNfYtESryY+w5NNMUMZc=";
    };
    date = "2024-04-09";
  };
  neovim = {
    pname = "neovim";
    version = "a1439ad7c584efb3d0ce14ccb835967f030450fe";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "a1439ad7c584efb3d0ce14ccb835967f030450fe";
      fetchSubmodules = false;
      sha256 = "sha256-yTVou/WArEWygBBs2NFPI9Dm9iSGfwVftKFbOAGl8tk=";
    };
    date = "2024-04-14";
  };
  palette = {
    pname = "palette";
    version = "408f081b6402d5d17b8324b75c6db5998100757d";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "palette";
      rev = "408f081b6402d5d17b8324b75c6db5998100757d";
      fetchSubmodules = false;
      sha256 = "sha256-JxwBb2JtDBVm8JPeshQfnjwEPZRbUqgKlDHybJ7LQrs=";
    };
    date = "2024-03-25";
  };
  polybar = {
    pname = "polybar";
    version = "989420b24e1f651b176c9d6083ad7c3b90a27f8b";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "polybar";
      rev = "989420b24e1f651b176c9d6083ad7c3b90a27f8b";
      fetchSubmodules = false;
      sha256 = "sha256-2fNqE5r6yMKH6h+rjXF/lnUjK2xc3uO+swCS4oqGenM=";
    };
    date = "2024-02-03";
  };
  rio = {
    pname = "rio";
    version = "a8d3d3c61f828da5f3d6d02d7d489108f6428178";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "rio";
      rev = "a8d3d3c61f828da5f3d6d02d7d489108f6428178";
      fetchSubmodules = false;
      sha256 = "sha256-bT789sEDJl3wQh/yfbmjD/J7XNr2ejOd0UsASguyCQo=";
    };
    date = "2023-12-05";
  };
  rofi = {
    pname = "rofi";
    version = "5350da41a11814f950c3354f090b90d4674a95ce";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "5350da41a11814f950c3354f090b90d4674a95ce";
      fetchSubmodules = false;
      sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
    };
    date = "2022-12-31";
  };
  starship = {
    pname = "starship";
    version = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      fetchSubmodules = false;
      sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
    };
    date = "2023-07-13";
  };
  sway = {
    pname = "sway";
    version = "9c430d7010d73444af5272a596e3a2c058612f71";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "sway";
      rev = "9c430d7010d73444af5272a596e3a2c058612f71";
      fetchSubmodules = false;
      sha256 = "sha256-EHZ/D4PrFqwyTpfcst3+hSx6z4saVD1M9CfFqnWI6io=";
    };
    date = "2024-04-03";
  };
  swaylock = {
    pname = "swaylock";
    version = "77246bbbbf8926bdb8962cffab6616bc2b9e8a06";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "swaylock";
      rev = "77246bbbbf8926bdb8962cffab6616bc2b9e8a06";
      fetchSubmodules = false;
      sha256 = "sha256-AKiOeV9ggvsreC/lq2qXytUsR+x66Q0kpN2F4/Oh2Ao=";
    };
    date = "2024-04-01";
  };
  tmux = {
    pname = "tmux";
    version = "a556353d60833367b13739e660d4057a96f2f4fe";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "a556353d60833367b13739e660d4057a96f2f4fe";
      fetchSubmodules = false;
      sha256 = "sha256-i5rnMnkFGOWeRi38euttei/fVIxlrV6dQxemAM+LV0A=";
    };
    date = "2024-04-21";
  };
  yazi = {
    pname = "yazi";
    version = "0846aed69b2a62d29c98e100af0cf55ca729723d";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "0846aed69b2a62d29c98e100af0cf55ca729723d";
      fetchSubmodules = false;
      sha256 = "sha256-2T41qWMe++3Qxl9veRNHMeRI3eU4+LAueKTss02gYNk=";
    };
    date = "2024-02-21";
  };
  zathura = {
    pname = "zathura";
    version = "0adc53028d81bf047461bc61c43a484d11b15220";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "zathura";
      rev = "0adc53028d81bf047461bc61c43a484d11b15220";
      fetchSubmodules = false;
      sha256 = "sha256-/vD/hOi6KcaGyAp6Az7jL5/tQSGRzIrf0oHjAJf4QbI=";
    };
    date = "2024-04-04";
  };
}
