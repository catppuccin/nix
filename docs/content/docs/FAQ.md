---
title: Frequently Asked Questions
description: Find the most common issues and questions about catppuccin/nix
---

Here we keep a list of common issues and questions, and all the answers to
them. Feel free to add more!

## How do I know what programs are supported?

You can find programs supported through home-manager
[here](https://nix.catppuccin.com/options/main/home/catppuccin/), and NixOS
modules [here](https://nix.catppuccin.com/options/main/nixos/catppuccin/).

## How do I set `catppuccin.enable` for everything I use?

You can set `catppuccin.enable` globally through home-manager
[here](/options/main/home/catppuccin/#catppuccin-enable), and NixOS modules
[here](/options/main/nixos/catppuccin/#catppuccin-enable).

## What versions of NixOS and home-manager are supported?

We primarily support the `unstable` branch, but try our best to support the
current stable release. You can check if your stable release is currently
supported at [status.nixos.org](https://status.nixos.org/).

## How do I fix the error: `... during evaluation because the option 'allow-import-from-derivation' is disabled`

Some ports need to read and/or manipulate remote resources, resulting in Nix
performing
[IFD](https://nix.dev/manual/nix/latest/language/import-from-derivation). We
try to avoid this where possible, but sometimes we need to use it. Check out
[our tracking issue](https://github.com/catppuccin/nix/issues/392) to see what
ports are affected.

## How do I fix the error: `a '...' with features {} is required to build '...'`?

See the above
