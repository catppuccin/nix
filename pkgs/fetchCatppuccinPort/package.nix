{ lib, fetchFromGitHub }:

lib.makeOverridable (
  {
    port,
    rev,
    hash,
    lastModified ? null,
    ...
  }@args:

  let
    arguments = [
      "port"
      "lastModified"
      "passthru"
    ];
  in

  fetchFromGitHub (
    {
      owner = "catppuccin";
      repo = port;
      inherit rev hash;
      passthru =
        lib.optionalAttrs (lastModified != null) {
          lastModified = lastModified;
        }
        // args.passthru or { };
    }
    // lib.removeAttrs args arguments
  )
)
