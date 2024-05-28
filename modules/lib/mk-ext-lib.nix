{
  config,
  lib,
  pkgs,
  ...
}:
lib.extend (
  final: _: {
    ctp = import ./. {
      inherit config pkgs;
      lib = final;
    };
  }
)
