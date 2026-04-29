---
title: Customisation
description: Customise the packages catppuccin/nix uses to build themes
---

Internally, `catppuccin/nix` exposes the packages it uses to fetch ports and
generate themes through the
[`catppuccin.sources`](/options/main/nixos/catppuccin/#catppuccin-sources)
option. The package set is modularised such that you could swap out a single package and it
wouldn't trigger a rebuild beyond that single isolated package. However, you can trigger a
mass rebuild manually, via `overideScope`. Each approach has their own respective
benefits dependent on your goal.

Some examples of this may include but are not limited to:

- applying [color overrides] to every port that uses [whiskers]
- pinning a port to a specific revision

[color overrides]: https://whiskers.catppuccin.com/concepts/overrides/#color-overrides
[whiskers]: https://github.com/catppuccin/whiskers

## Overriding sources

There are a few ways to change the sources for the ports, the easiest is simply
to add to `catppuccin.sources`.

```nix
{ lib, pkgs, config, ... }:
{
  catppuccin.sources = {
    bat = config.catppuccin.sources.fetchCatppuccinPort {
      port = "bat";
      hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
      lastModified = "2025-06-29";
      rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
    };
  };
}
```

Another method of triggering a mass-rebuild for any dependent packages
may take a form such as the following:

```nix
{ inputs, ... }:
{
  catppuccin.sources = inputs.catppuccin.packages.x86_64-linux.overideScope (
    final: prev: {
      bat = prev.fetchCatppuccinPort {
        port = "bat";
        hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        lastModified = "2025-06-29";
        rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
      };
    }
  );
}
```

## Example: OLED colour overrides

The majority of our ports use [`whiskers`][whiskers] to build the final themed
files. By wrapping `whiskers` to call with the [`--color-overrides`][color
overrides] flag, every port that is built using it will be built with those respective colors replaced.

The following snippet demonstrates an example that replaces the standard mocha background
with pure black, producing the popular oledpuccin variant:

```nix
{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  oled = {
    mocha = {
      base = "000000";
      mantle = "010101";
      crust = "020202";
    };
  };
in
{
  catppuccin.sources = inputs.catppuccin.x86_64-linux.packages.overrideScope (
    final: prev: {
      whiskers = pkgs.symlinkJoin {
        name = "whiskers-wrapped";

        paths = [ prev.whiskers ];
        nativeBuildInputs = [ pkgs.makeBinaryWrapper ];

        postBuild = ''
          wrapProgram $out/bin/whiskers \
            --add-flag ${lib.escapeShellArg "--color-overrides=${builtins.toJSON oled}"}
        '';

        meta.mainProgram = "whiskers";
      };
    }
  );
}
```
