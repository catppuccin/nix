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
    ];
  in

  fetchFromGitHub (
    lib.recursiveUpdate {
      owner = "catppuccin";
      repo = port;
      inherit rev hash;
      passthru = lib.optionalAttrs (lastModified != null) {
        lastModified = lastModified;
      };
    } (lib.removeAttrs args arguments)
  )
)
