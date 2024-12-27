{
  lib,
  callPackage,
  linkFarm,
  writeText,

  nuscht-search,
  inputs,
  /*
    Should be in the format of

    ```
    {
      <version name> = <flake input>;
    }
    ```

    i.e.,

    ```
    {
      "v1.1" = catppuccin_v1_1;
      "rolling" = self;
    }
  */
  searchVersions ? null,
}:

assert lib.assertMsg (
  searchVersions != null
) "./docs/package.nix: `searchVersions` must be provided";

let
  inherit (inputs) self;

  mkSite = callPackage ./mk-site.nix { };
  mkSearchInstance = callPackage ./mk-search.nix {
    inherit (nuscht-search) mkMultiSearch;
  };

  # Collect the latest stable version from the `searchVersions` given
  latestStableVersion =
    let
      latest = lib.foldl' (
        latest: versionName:
        if (versionName != "rolling" && lib.versionOlder latest (lib.removePrefix "v" versionName)) then
          versionName
        else
          latest
      ) "0" (lib.attrNames searchVersions);
    in
    assert lib.assertMsg (latest != "0") "Unable to determine latest stable version!";
    latest;

  # Then create a search instance for each one
  searchInstances = lib.mapAttrs (
    versionName: catppuccin: mkSearchInstance { inherit catppuccin versionName; }
  ) searchVersions;

  # Create an html page for redirecting to a given endpoint
  redirectTo =
    endpoint:
    writeText "index.html" ''
      <meta http-equiv="refresh" content="0;url=${endpoint}">
    '';
in

mkSite {
  pname = "catppuccin-nix-site";
  version = self.shortRev or self.dirtyShortRev or "unknown";

  src = self + "/docs";

  postPatch = "ln -sf ${self + "/CHANGELOG.md"} src/NEWS.md";

  postInstall = ''
    ln -sf ${
      linkFarm "search-engines" (
        [
          {
            name = "stable.html";
            path = redirectTo "/search/${latestStableVersion}/";
          }
          {
            name = "index.html";
            path = redirectTo "/search/stable.html";
          }
        ]
        ++ lib.mapAttrsToList (name: path: { inherit name path; }) searchInstances
      )
    } $out/search
  '';
}
