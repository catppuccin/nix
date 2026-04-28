{ lib, fetchFromGitHub }:

lib.makeOverridable (
  {
    port,
    rev ? null,
    tag ? null,
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
      inherit rev tag hash;
      passthru =
        lib.optionalAttrs (lastModified != null) {
          lastModified = lastModified;
        }
        // args.passthru or { };
    }
    // lib.removeAttrs args arguments
  )
)
