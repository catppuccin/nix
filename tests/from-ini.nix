lib:
let
  subject = import ../modules/lib/from-ini.nix lib;

  input = ''
    k=v

    [a]
    k=v
    #comment
    kk='vv'

    [aa]
    k = v
    #comment
    kk = 'vv'
  '';

  expected = {
    k = "v";
    a = {
      k = "v";
      kk = "vv";
    };
    aa = {
      k = "v";
      kk = "vv";
    };
  };

  actual = subject input;
in
  actual == expected
