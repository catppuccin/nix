{ lib, fetchFromGitHub }:

lib.makeOverridable (
  {
    port,
    rev,
    hash,
    ...
  }@args:

  let
    arguments = [ "port" ];
  in

  fetchFromGitHub (
    {
      owner = "catppuccin";
      repo = port;
      inherit rev hash;
    }
    // lib.removeAttrs args arguments
  )
)
