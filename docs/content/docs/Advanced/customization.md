---
title: Customization
description: Customize the packages catppuccin/nix uses to build themes
---

Internally, `catppuccin/nix` exposes the packages it uses to fetch ports and
generate themes through the
[`catppuccin.sources`](/options/main/nixos/catppuccin/#catppuccin-sources)
option. The package set is modularized such that you could swap out a single package and it
wouldn't trigger a rebuild beyond that single isolated package. However, you can trigger a
mass rebuild manually, via `overideScope`. Each approach has their own respective
benefits depending on your goal.

Some examples of this may include but are not limited to:

- Applying [color overrides] to every port that uses [whiskers]
- Pinning a port to a specific revision

[color overrides]: https://whiskers.catppuccin.com/concepts/overrides/#color-overrides
[whiskers]: https://github.com/catppuccin/whiskers

## Overriding Sources

There are a few ways to change the port sources, the easiest is simply
to add it to `catppuccin.sources`:

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
  catppuccin.sources = inputs.catppuccin.packages.x86_64-linux.overrideScope (
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

Note that you can freely modify the sources here.
The sources are derivations, so it's possible to adjust them as you would with any package derivation.
For example, if you have a custom fork of a theme (here: `my-catppuccin-bat-fork` as part of `inputs`),
you can override the package source:

```nix
{ inputs, ... }:
{
  catppuccin.sources = inputs.catppuccin.packages.x86_64-linux.overrideScope (
    final: prev: {
      bat = prev.bat.overrideAttrs {
        src = inputs.my-catppuccin-bat-fork;
      };
    }
  );
}
```

## Example: OLED Color Overrides

The majority of our ports use [`whiskers`][whiskers] to build the final themed
files. By wrapping `whiskers` to call it with the [`--color-overrides`][color
overrides] flag, every port that is built using it will be built with those respective colors replaced.

The following snippet demonstrates an example that replaces the standard mocha background
with pure black, producing the popular _oledpuccin_ variant:

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
