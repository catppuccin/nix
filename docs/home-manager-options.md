## catppuccin\.enable



Whether to enable Catppuccin globally\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## catppuccin\.accent

Global Catppuccin accent



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## catppuccin\.flavour



Global Catppuccin flavour



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## catppuccin\.sources



Port sources used across all options



*Type:*
lazy attribute set of raw value



*Default:*

```
{
  alacritty = {
    branch = "main";
    hash = "0rj7d4aalrfv0yy1ympg3qvwjk2wygaavbha385z1h7prf4lfb9y";
    outPath = "/nix/store/hh6ybphvni36i0c980swpgabn7axp81r-source";
    repository = {
      owner = "catppuccin";
      repo = "alacritty";
      type = "GitHub";
    };
    revision = "94800165c13998b600a9da9d29c330de9f28618e";
    type = "Git";
    url = "https://github.com/catppuccin/alacritty/archive/94800165c13998b600a9da9d29c330de9f28618e.tar.gz";
  };
  bat = {
    branch = "main";
    hash = "1zlryg39y4dbrycjlp009vd7hx2yvn5zfb03a2vq426z78s7i423";
    outPath = "/nix/store/p50vg9ycsywxm7gl88s12zd234kp7qyc-source";
    repository = {
      owner = "catppuccin";
      repo = "bat";
      type = "GitHub";
    };
    revision = "d714cc1d358ea51bfc02550dabab693f70cccea0";
    type = "Git";
    url = "https://github.com/catppuccin/bat/archive/d714cc1d358ea51bfc02550dabab693f70cccea0.tar.gz";
  };
  bottom = {
    branch = "main";
    hash = "0wni1y06l75nmb7242wza66dxf79qwcj89g87j34ln650nyrmv8r";
    outPath = "/nix/store/kasrvkpsj90bq02kk36jvjr3zshsxhyz-source";
    repository = {
      owner = "catppuccin";
      repo = "bottom";
      type = "GitHub";
    };
    revision = "66c540ea512187df5f0c6c97312b0c6da7225af0";
    type = "Git";
    url = "https://github.com/catppuccin/bottom/archive/66c540ea512187df5f0c6c97312b0c6da7225af0.tar.gz";
  };
  btop = {
    branch = "main";
    hash = "0ayhpfdldnmdb2xirrj2p85bcpi17kwza65b6ridakznhyblk1wf";
    outPath = "/nix/store/8h0qncz3c83kyxc3vaqn4qpp3z5hvm59-source";
    repository = {
      owner = "catppuccin";
      repo = "btop";
      type = "GitHub";
    };
    revision = "c6469190f2ecf25f017d6120bf4e050e6b1d17af";
    type = "Git";
    url = "https://github.com/catppuccin/btop/archive/c6469190f2ecf25f017d6120bf4e050e6b1d17af.tar.gz";
  };
  cava = {
    branch = "main";
    hash = "0saz99k2gb2xg8wl3qcfn7xxmvdp0qhbzas2mqxackxbbdh49lql";
    outPath = "/nix/store/kxlr36kbc1p4z7fs2hw3diyvxzhz4lmv-source";
    repository = {
      owner = "catppuccin";
      repo = "cava";
      type = "GitHub";
    };
    revision = "56c1e69318856a853b28e3ccce500c00099dc051";
    type = "Git";
    url = "https://github.com/catppuccin/cava/archive/56c1e69318856a853b28e3ccce500c00099dc051.tar.gz";
  };
  delta = {
    branch = "main";
    hash = "00pmg2rbzsrf2k0l6d7m5394i7klvk41h6xhv8c3v56rhvv2f38q";
    outPath = "/nix/store/88xijsnl0lg6qx5k658b2g5g8rcfq5ys-source";
    repository = {
      owner = "catppuccin";
      repo = "delta";
      type = "GitHub";
    };
    revision = "765eb17d0268bf07c20ca439771153f8bc79444f";
    type = "Git";
    url = "https://github.com/catppuccin/delta/archive/765eb17d0268bf07c20ca439771153f8bc79444f.tar.gz";
  };
  dunst = {
    branch = "main";
    hash = "0q3p4r3in22r3bj7npk7ww5hd14p3gwch2iqxi7sjf3bj077sby7";
    outPath = "/nix/store/4h6igy6caak91v1zsdq380k3cqpga9nk-source";
    repository = {
      owner = "catppuccin";
      repo = "dunst";
      type = "GitHub";
    };
    revision = "bfec91a5d0ab02a73a4615243feb5499d376831c";
    type = "Git";
    url = "https://github.com/catppuccin/dunst/archive/bfec91a5d0ab02a73a4615243feb5499d376831c.tar.gz";
  };
  fcitx5 = {
    branch = "main";
    hash = "16qs60k7nskvf9v0ivz1izkiirf3fd8jscx5i0lgx3n459pq4mmq";
    outPath = "/nix/store/4mcxaxsdk0fgz0c8aak1v5j9p5pby9i1-source";
    repository = {
      owner = "catppuccin";
      repo = "fcitx5";
      type = "GitHub";
    };
    revision = "ce244cfdf43a648d984719fdfd1d60aab09f5c97";
    type = "Git";
    url = "https://github.com/catppuccin/fcitx5/archive/ce244cfdf43a648d984719fdfd1d60aab09f5c97.tar.gz";
  };
  fish = {
    branch = "main";
    hash = "1a6yj6zhccpg5jpcrxjzxyydh5ldwlvwf3vz6lwl60gk2xvz7kqd";
    outPath = "/nix/store/l7bcp3qv44inifffpsic2k1gzjyibdj7-source";
    repository = {
      owner = "catppuccin";
      repo = "fish";
      type = "GitHub";
    };
    revision = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    type = "Git";
    url = "https://github.com/catppuccin/fish/archive/0ce27b518e8ead555dec34dd8be3df5bd75cff8e.tar.gz";
  };
  foot = {
    branch = "main";
    hash = "0ki01m4r3rxsx0vqjylwa3i6f6k8lf1xbsx2kv1xfzbd68fdhhws";
    outPath = "/nix/store/3lwvzm4k4r2l921pyad9jb2gwacl3ibf-source";
    repository = {
      owner = "catppuccin";
      repo = "foot";
      type = "GitHub";
    };
    revision = "307611230661b7b1787feb7f9d122e851bae97e9";
    type = "Git";
    url = "https://github.com/catppuccin/foot/archive/307611230661b7b1787feb7f9d122e851bae97e9.tar.gz";
  };
  gh-dash = {
    branch = "main";
    hash = "0w70py16slwcjbc96d269dpq7xkm1rv846hv2mzb7v1x1n74xcfd";
    outPath = "/nix/store/xh020zvs82s13cvmpbbs4ys2x95pnb4s-source";
    repository = {
      owner = "catppuccin";
      repo = "gh-dash";
      type = "GitHub";
    };
    revision = "a971447dbb6e43c274ce52697c0bd381735c3c8a";
    type = "Git";
    url = "https://github.com/catppuccin/gh-dash/archive/a971447dbb6e43c274ce52697c0bd381735c3c8a.tar.gz";
  };
  gitui = {
    branch = "main";
    hash = "10kwkkp2zlzzmj7c6bkhxmk21r5g5qckpw9myc9sp8dfbx1qfrli";
    outPath = "/nix/store/zffda06bh1qr3xcv306gc9v0sl2am5a0-source";
    repository = {
      owner = "catppuccin";
      repo = "gitui";
      type = "GitHub";
    };
    revision = "39978362b2c88b636cacd55b65d2f05c45a47eb9";
    type = "Git";
    url = "https://github.com/catppuccin/gitui/archive/39978362b2c88b636cacd55b65d2f05c45a47eb9.tar.gz";
  };
  glamour = {
    branch = "main";
    hash = "1072gspp20qln7ladqzqahzc3c1444d9hczmafygnazpla14awkz";
    outPath = "/nix/store/fvj5sxcsmwvgpyz1x6p56fdbq99kv2yn-source";
    repository = {
      owner = "catppuccin";
      repo = "glamour";
      type = "GitHub";
    };
    revision = "66d7b09325af67b1c5cdb063343e829c04ad7d5f";
    type = "Git";
    url = "https://github.com/catppuccin/glamour/archive/66d7b09325af67b1c5cdb063343e829c04ad7d5f.tar.gz";
  };
  grub = {
    branch = "main";
    hash = "0rih0ra7jw48zpxrqwwrw1v0xay7h9727445wfbnrz6xwrcwbibv";
    outPath = "/nix/store/5h2jlq7zjk8ss3vq1sarp89lip5b4kkv-source";
    repository = {
      owner = "catppuccin";
      repo = "grub";
      type = "GitHub";
    };
    revision = "88f6124757331fd3a37c8a69473021389b7663ad";
    type = "Git";
    url = "https://github.com/catppuccin/grub/archive/88f6124757331fd3a37c8a69473021389b7663ad.tar.gz";
  };
  gtk = {
    branch = "main";
    hash = "0lssds5w78csb9hm22wilaglp9yj2bln7n1d57b2zmb05d3fj8kl";
    outPath = "/nix/store/1isn2015y2sgipsxww1r1rspklj0rlzy-source";
    repository = {
      owner = "catppuccin";
      repo = "gtk";
      type = "GitHub";
    };
    revision = "0c3e8817da94769887c690b2211e006b287b27b1";
    type = "Git";
    url = "https://github.com/catppuccin/gtk/archive/0c3e8817da94769887c690b2211e006b287b27b1.tar.gz";
  };
  helix = {
    branch = "main";
    hash = "1frrvsw3im3llq9l8vg2j7n3pg8a2gqvqd0cmymzpllnbhd9rpzi";
    outPath = "/nix/store/9ksxi19d5gk9y8gdq1v10kq8gpb4pzr2-source";
    repository = {
      owner = "catppuccin";
      repo = "helix";
      type = "GitHub";
    };
    revision = "0164c4ca888084df4f511da22c6a0a664b5061d2";
    type = "Git";
    url = "https://github.com/catppuccin/helix/archive/0164c4ca888084df4f511da22c6a0a664b5061d2.tar.gz";
  };
  hyprland = {
    branch = "main";
    hash = "1vz0xbj26qb1vvzi18b5wrdla042vdyd3l4m98h7ay0fwydajfjx";
    outPath = "/nix/store/skh7imcnv9qjmqz92g8x6467yslwr5k7-source";
    repository = {
      owner = "catppuccin";
      repo = "hyprland";
      type = "GitHub";
    };
    revision = "b57375545f5da1f7790341905d1049b1873a8bb3";
    type = "Git";
    url = "https://github.com/catppuccin/hyprland/archive/b57375545f5da1f7790341905d1049b1873a8bb3.tar.gz";
  };
  imv = {
    branch = "main";
    hash = "12df3lvsbss433m938fbm9snxv324s8z2j37jjfj6mb2rv21palz";
    outPath = "/nix/store/3hipvfvbmssxsag4597kb3167hmgs420-source";
    repository = {
      owner = "catppuccin";
      repo = "imv";
      type = "GitHub";
    };
    revision = "0317a097b6ec8122b1da6d02f61d0c5158019f6e";
    type = "Git";
    url = "https://github.com/catppuccin/imv/archive/0317a097b6ec8122b1da6d02f61d0c5158019f6e.tar.gz";
  };
  k9s = {
    branch = "main";
    hash = "1ndpmvga2sjgvsi449djw5pqx6b0ig3873p4gpxbm6b3lhdvpf2l";
    outPath = "/nix/store/ya4wm30h8mr8iala4ihh7yxdgyq6457l-source";
    repository = {
      owner = "catppuccin";
      repo = "k9s";
      type = "GitHub";
    };
    revision = "82eba6feb442932e28facedfb18dfbe79234f180";
    type = "Git";
    url = "https://github.com/catppuccin/k9s/archive/82eba6feb442932e28facedfb18dfbe79234f180.tar.gz";
  };
  kitty = {
    branch = "main";
    hash = "0cr244zwh46vgjw2i6j53f6n02gc48ry6s0xmna91f0zipxml4cr";
    outPath = "/nix/store/xa1jb3xkl669y367j38r055a98jms2qr-source";
    repository = {
      owner = "catppuccin";
      repo = "kitty";
      type = "GitHub";
    };
    revision = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
    type = "Git";
    url = "https://github.com/catppuccin/kitty/archive/d7d61716a83cd135344cbb353af9d197c5d7cec1.tar.gz";
  };
  lazygit = {
    branch = "main";
    hash = "0hw0vv0k5m6vs51iridbiqmhza59j26wmrkydx1gfijfrbn40qws";
    outPath = "/nix/store/wxhdkj2b1m00ir5lb8n7d2jzyygwalwa-source";
    repository = {
      owner = "catppuccin";
      repo = "lazygit";
      type = "GitHub";
    };
    revision = "30bff2e6d14ca12a09d71e5ce4e6a086b3e48aa6";
    type = "Git";
    url = "https://github.com/catppuccin/lazygit/archive/30bff2e6d14ca12a09d71e5ce4e6a086b3e48aa6.tar.gz";
  };
  mako = {
    branch = "main";
    hash = "097x9jrkzvml6ngnhxwkzzl1l2awwv73yli1mhmpw83c0n8xck4x";
    outPath = "/nix/store/dgry1k0wg3k3wgl04ccjr7x2k43zb0sz-source";
    repository = {
      owner = "catppuccin";
      repo = "mako";
      type = "GitHub";
    };
    revision = "9dd088aa5f4529a3dd4d9760415e340664cb86df";
    type = "Git";
    url = "https://github.com/catppuccin/mako/archive/9dd088aa5f4529a3dd4d9760415e340664cb86df.tar.gz";
  };
  micro = {
    branch = "main";
    hash = "0vqhzd35gfv6r28mlyl9picrbfk8kmniyvsyf5b3cqnbjvxik77w";
    outPath = "/nix/store/ghykjrr6b6zbmi4lv8v8g6mp6z78c0s3-source";
    repository = {
      owner = "catppuccin";
      repo = "micro";
      type = "GitHub";
    };
    revision = "ed8ef015f97c357575b5013e18042c9faa6c068a";
    type = "Git";
    url = "https://github.com/catppuccin/micro/archive/ed8ef015f97c357575b5013e18042c9faa6c068a.tar.gz";
  };
  mpv = {
    branch = "main";
    hash = "10h7xl9fxrakibi1f61ca9l1i528fnhbyqfz16k096yiklr2aa22";
    outPath = "/nix/store/12a7j2dgqlk663ji3jm40wfaif5bpxhj-source";
    repository = {
      owner = "catppuccin";
      repo = "mpv";
      type = "GitHub";
    };
    revision = "7fc6ed93dec891865d0b42be42ba9b4fb7d5a338";
    type = "Git";
    url = "https://github.com/catppuccin/mpv/archive/7fc6ed93dec891865d0b42be42ba9b4fb7d5a338.tar.gz";
  };
  nvim = {
    branch = "main";
    hash = "1wybci6cjadjd5z0wkx2jmwb9ir72s4g4qrd9qsjl2qjfiaf26k9";
    outPath = "/nix/store/hmx4c11kfkld9ck2giv6dk5bfaai3xw8-source";
    repository = {
      owner = "catppuccin";
      repo = "nvim";
      type = "GitHub";
    };
    revision = "d97387aea8264f484bb5d5e74f2182a06c83e0d8";
    type = "Git";
    url = "https://github.com/catppuccin/nvim/archive/d97387aea8264f484bb5d5e74f2182a06c83e0d8.tar.gz";
  };
  palette = {
    branch = "main";
    hash = "1fs2rfg6rwiijh5ahljvjhyh8g4y3wab5plky1k1a33dc9ph2717";
    outPath = "/nix/store/c718k4zk8l0bsybi0x5zfwyvb9hakvz4-source";
    repository = {
      owner = "catppuccin";
      repo = "palette";
      type = "GitHub";
    };
    revision = "408f081b6402d5d17b8324b75c6db5998100757d";
    type = "Git";
    url = "https://github.com/catppuccin/palette/archive/408f081b6402d5d17b8324b75c6db5998100757d.tar.gz";
  };
  polybar = {
    branch = "main";
    hash = "0wvshs5f54h0nfzf7pjwdhmj6xcngxqqvaqzxa3w5j7sk89nmwyr";
    outPath = "/nix/store/hcf1xhwrqi0r8n1rldd04d3hl0bl988s-source";
    repository = {
      owner = "catppuccin";
      repo = "polybar";
      type = "GitHub";
    };
    revision = "989420b24e1f651b176c9d6083ad7c3b90a27f8b";
    type = "Git";
    url = "https://github.com/catppuccin/polybar/archive/989420b24e1f651b176c9d6083ad7c3b90a27f8b.tar.gz";
  };
  rio = {
    branch = "main";
    hash = "02h9n85ll02bs6fk6ypnv9f7pwhglfwpvwhz8bq5s9h3q7vgqgkd";
    outPath = "/nix/store/bfk35d226d5xi7imzi1gjqk9mqsl101k-source";
    repository = {
      owner = "catppuccin";
      repo = "rio";
      type = "GitHub";
    };
    revision = "a8d3d3c61f828da5f3d6d02d7d489108f6428178";
    type = "Git";
    url = "https://github.com/catppuccin/rio/archive/a8d3d3c61f828da5f3d6d02d7d489108f6428178.tar.gz";
  };
  rofi = {
    branch = "main";
    hash = "15phrl9qlbzjxmp29hak3a5k015x60w2hxjif90q82vp55zjpnhc";
    outPath = "/nix/store/nksrp1bi6yh7m969m15insmaavhk1r51-source";
    repository = {
      owner = "catppuccin";
      repo = "rofi";
      type = "GitHub";
    };
    revision = "5350da41a11814f950c3354f090b90d4674a95ce";
    type = "Git";
    url = "https://github.com/catppuccin/rofi/archive/5350da41a11814f950c3354f090b90d4674a95ce.tar.gz";
  };
  skim = {
    branch = "main";
    hash = "1b6cd1wfkprrn7imgf1w1f9a6iqy3bql2ansy7l0k44ps1gwrvxq";
    outPath = "/nix/store/lkdjwfad4z8rwaq5nfifmd3v74plaxh7-source";
    repository = {
      owner = "catppuccin";
      repo = "skim";
      type = "GitHub";
    };
    revision = "d39304b5f84721788b19bc40aebcfd7720208d8a";
    type = "Git";
    url = "https://github.com/catppuccin/skim/archive/d39304b5f84721788b19bc40aebcfd7720208d8a.tar.gz";
  };
  starship = {
    branch = "main";
    hash = "1bdm1vzapbpnwjby51dys5ayijldq05mw4wf20r0jvaa072nxi4y";
    outPath = "/nix/store/7dsn158hgi4q5wjag8lca156ny9vqw33-source";
    repository = {
      owner = "catppuccin";
      repo = "starship";
      type = "GitHub";
    };
    revision = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
    type = "Git";
    url = "https://github.com/catppuccin/starship/archive/5629d2356f62a9f2f8efad3ff37476c19969bd4f.tar.gz";
  };
  sway = {
    branch = "main";
    hash = "0apai1ssmi97yi63sm0sig7plb45zvfv5p4p9qraq5pbhc7pyxhh";
    outPath = "/nix/store/p305n750cm27ng77f0mq2w0862nba3cl-source";
    repository = {
      owner = "catppuccin";
      repo = "sway";
      type = "GitHub";
    };
    revision = "9c430d7010d73444af5272a596e3a2c058612f71";
    type = "Git";
    url = "https://github.com/catppuccin/sway/archive/9c430d7010d73444af5272a596e3a2c058612f71.tar.gz";
  };
  swaylock = {
    branch = "main";
    hash = "02nql7ry71fxlhj0vsbsxi3jrmfajxmapr9gg0mzp0k0bxwqxa00";
    outPath = "/nix/store/rvnbnr3wss7791116hkl6c096w4v0i9r-source";
    repository = {
      owner = "catppuccin";
      repo = "swaylock";
      type = "GitHub";
    };
    revision = "77246bbbbf8926bdb8962cffab6616bc2b9e8a06";
    type = "Git";
    url = "https://github.com/catppuccin/swaylock/archive/77246bbbbf8926bdb8962cffab6616bc2b9e8a06.tar.gz";
  };
  tmux = {
    branch = "main";
    hash = "0fimahk7yw2r3w562nazh6yhi4p8531w28p7pfk9nvlrmrcsfy0h";
    outPath = "/nix/store/1r3ys3qdi9ii8vbgxvs94lm945zbbh3g-source";
    repository = {
      owner = "catppuccin";
      repo = "tmux";
      type = "GitHub";
    };
    revision = "697087f593dae0163e01becf483b192894e69e33";
    type = "Git";
    url = "https://github.com/catppuccin/tmux/archive/697087f593dae0163e01becf483b192894e69e33.tar.gz";
  };
  tofi = {
    branch = "main";
    hash = "1izqm6vf6n8d1ig1hvmgzwm2azrswz2g3k0i97d2fnxnzk324k2x";
    outPath = "/nix/store/4v2yz9nbfqaib49djs1fidhak4zphh55-source";
    repository = {
      owner = "catppuccin";
      repo = "tofi";
      type = "GitHub";
    };
    revision = "2e74ddba0c582b2ca2d9d06f67f5a902c3a093fb";
    type = "Git";
    url = "https://github.com/catppuccin/tofi/archive/2e74ddba0c582b2ca2d9d06f67f5a902c3a093fb.tar.gz";
  };
  waybar = {
    branch = "main";
    hash = "0np88b9zi6zk21fy5w4kmgjg1clqp4ggw1hijlv9qvlka2zkwmpn";
    outPath = "/nix/store/1c8qc6hm56hjk48smc5337d9mnxx188p-source";
    repository = {
      owner = "catppuccin";
      repo = "waybar";
      type = "GitHub";
    };
    revision = "0830796af6aa64ce8bc7453d42876a628777ac68";
    type = "Git";
    url = "https://github.com/catppuccin/waybar/archive/0830796af6aa64ce8bc7453d42876a628777ac68.tar.gz";
  };
  yazi = {
    branch = "main";
    hash = "1nb0l16v7v54g0pb1y1qwpflir1i8w9pjvszqv8fvyqycflkagnr";
    outPath = "/nix/store/wpmsxds1hn1wvjs2swpwxn1gwm06ra14-source";
    repository = {
      owner = "catppuccin";
      repo = "yazi";
      type = "GitHub";
    };
    revision = "0846aed69b2a62d29c98e100af0cf55ca729723d";
    type = "Git";
    url = "https://github.com/catppuccin/yazi/archive/0846aed69b2a62d29c98e100af0cf55ca729723d.tar.gz";
  };
  zathura = {
    branch = "main";
    hash = "1cj1z2bh1qw1sbgqmk4i450yv7rgwcz06yhar23ccadsx22gzw7y";
    outPath = "/nix/store/m2yahxxw4db79gvncy286mi3n4a6vpwr-source";
    repository = {
      owner = "catppuccin";
      repo = "zathura";
      type = "GitHub";
    };
    revision = "0adc53028d81bf047461bc61c43a484d11b15220";
    type = "Git";
    url = "https://github.com/catppuccin/zathura/archive/0adc53028d81bf047461bc61c43a484d11b15220.tar.gz";
  };
  zsh-syntax-highlighting = {
    branch = "main";
    hash = "1yj916klvzpvwghii7m6qx2ya3p2kx25nydymilvjzbx8z0sdcj3";
    outPath = "/nix/store/gmsnrmj9afqf1q0fksq6q0yxf4j5gz6f-source";
    repository = {
      owner = "catppuccin";
      repo = "zsh-syntax-highlighting";
      type = "GitHub";
    };
    revision = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
    type = "Git";
    url = "https://github.com/catppuccin/zsh-syntax-highlighting/archive/06d519c20798f0ebe275fc3a8101841faaeee8ea.tar.gz";
  };
}
```

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.accent



Catppuccin accent for gtk



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.cursor\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.cursor\.accent



Catppuccin accent for gtk cursors



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”, “dark”, “light”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.cursor\.flavour



Catppuccin flavour for gtk cursors



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.flavour



Catppuccin flavour for gtk



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.gnomeShellTheme



Whether to enable Catppuccin gtk theme for GNOME Shell\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.size



Catppuccin size variant for gtk



*Type:*
one of “standard”, “compact”



*Default:*
` "standard" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## gtk\.catppuccin\.tweaks



Catppuccin tweaks for gtk



*Type:*
list of (one of “black”, “rimless”, “normal”)



*Default:*

```
[
  "normal"
]
```

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## i18n\.inputMethod\.fcitx5\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## i18n\.inputMethod\.fcitx5\.catppuccin\.apply



Applies the theme by overwriting ` $XDG_CONFIG_HOME/fcitx5/conf/classicui.conf `\.
If this is disabled, you must manually set the theme (e\.g\. by using ` fcitx5-configtool `)\.



*Type:*
boolean



*Default:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## i18n\.inputMethod\.fcitx5\.catppuccin\.flavour



Catppuccin flavour for Fcitx5



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.alacritty\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.alacritty\.catppuccin\.flavour



Catppuccin flavour for alacritty



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.bat\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.bat\.catppuccin\.flavour



Catppuccin flavour for bat



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.bottom\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.bottom\.catppuccin\.flavour



Catppuccin flavour for bottom



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.btop\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.btop\.catppuccin\.flavour



Catppuccin flavour for btop



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.cava\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.cava\.catppuccin\.flavour



Catppuccin flavour for cava



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.fish\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.fish\.catppuccin\.flavour



Catppuccin flavour for fish



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.foot\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.foot\.catppuccin\.flavour



Catppuccin flavour for foot



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.fzf\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.fzf\.catppuccin\.flavour



Catppuccin flavour for fzf



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.gh-dash\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.gh-dash\.catppuccin\.accent



Catppuccin accent for gh-dash



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.gh-dash\.catppuccin\.flavour



Catppuccin flavour for gh-dash



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.git\.delta\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.git\.delta\.catppuccin\.flavour



Catppuccin flavour for catppuccin



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.gitui\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.gitui\.catppuccin\.flavour



Catppuccin flavour for gitui



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.glamour\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.glamour\.catppuccin\.flavour



Catppuccin flavour for glamour



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.helix\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.helix\.catppuccin\.flavour



Catppuccin flavour for helix



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.helix\.catppuccin\.useItalics



Whether to enable Italics in Catppuccin theme for Helix\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.imv\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.imv\.catppuccin\.flavour



Catppuccin flavour for imv



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.k9s\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.k9s\.catppuccin\.flavour



Catppuccin flavour for k9s



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.k9s\.catppuccin\.transparent



Whether to enable transparent version of flavour\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.kitty\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.kitty\.catppuccin\.flavour



Catppuccin flavour for kitty



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.lazygit\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.lazygit\.catppuccin\.accent



Catppuccin accent for lazygit



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.lazygit\.catppuccin\.flavour



Catppuccin flavour for lazygit



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.micro\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.micro\.catppuccin\.flavour



Catppuccin flavour for micro



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.mpv\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.mpv\.catppuccin\.accent



Catppuccin accent for mpv



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.mpv\.catppuccin\.flavour



Catppuccin flavour for mpv



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.neovim\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.neovim\.catppuccin\.flavour



Catppuccin flavour for neovim



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.rio\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.rio\.catppuccin\.flavour



Catppuccin flavour for rio



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.rofi\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.rofi\.catppuccin\.flavour



Catppuccin flavour for rofi



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.skim\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.skim\.catppuccin\.flavour



Catppuccin flavour for skim



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.starship\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.starship\.catppuccin\.flavour



Catppuccin flavour for starship



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.swaylock\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.swaylock\.catppuccin\.flavour



Catppuccin flavour for swaylock



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.tmux\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.tmux\.catppuccin\.extraConfig



Additional configuration for the catppuccin plugin\.



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `



*Example:*

```
''
  set -g @catppuccin_status_modules_right "application session user host date_time"
''
```

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.tmux\.catppuccin\.flavour



Catppuccin flavour for tmux



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.tofi\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.tofi\.catppuccin\.flavour



Catppuccin flavour for tofi



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.waybar\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.waybar\.catppuccin\.flavour



Catppuccin flavour for waybar



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.waybar\.catppuccin\.mode



Defines how to include the catppuccin theme css file:

 - ` prependImport `: Prepends the import statement, if ` programs.waybar.style ` is a string (with default override priority)\.
 - ` createLink `: Creates a symbolic link ` ~/.config/waybar/catppuccin.css `, which needs to be included in the waybar stylesheet\.



*Type:*
one of “prependImport”, “createLink”



*Default:*
` "prependImport" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.yazi\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.yazi\.catppuccin\.flavour



Catppuccin flavour for yazi



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zathura\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zathura\.catppuccin\.flavour



Catppuccin flavour for zathura



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zellij\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zellij\.catppuccin\.flavour



Catppuccin flavour for zellij



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zsh\.syntaxHighlighting\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## programs\.zsh\.syntaxHighlighting\.catppuccin\.flavour



Catppuccin flavour for zsh syntax highlighting



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.dunst\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.dunst\.catppuccin\.flavour



Catppuccin flavour for dunst



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.mako\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.mako\.catppuccin\.flavour



Catppuccin flavour for mako



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.polybar\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## services\.polybar\.catppuccin\.flavour



Catppuccin flavour for polybar



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## wayland\.windowManager\.hyprland\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## wayland\.windowManager\.hyprland\.catppuccin\.accent



Catppuccin accent for hyprland



*Type:*
one of “blue”, “flamingo”, “green”, “lavender”, “maroon”, “mauve”, “peach”, “pink”, “red”, “rosewater”, “sapphire”, “sky”, “teal”, “yellow”



*Default:*
` "mauve" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## wayland\.windowManager\.hyprland\.catppuccin\.flavour



Catppuccin flavour for hyprland



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## wayland\.windowManager\.sway\.catppuccin\.enable



Whether to enable Catppuccin theme\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)



## wayland\.windowManager\.sway\.catppuccin\.flavour



Catppuccin flavour for sway



*Type:*
one of “latte”, “frappe”, “macchiato”, “mocha”



*Default:*
` "mocha" `

*Declared by:*
 - [/nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager](file:///nix/store/j4bpskj5l3n998p48i87g0jygh3vvgdv-source/modules/home-manager)


