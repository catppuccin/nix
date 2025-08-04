---
title: Contributing
description: Contributing guidelines for catppuccin/nix
---

## Adding a port

:::note
Unofficial ports will not be accepted. All sources must be from the
[Catppuccin](https://github.com/catppuccin) GitHub organization
:::

Create a file in `modules/<module>/` with the name of the port. All ports should have
the `catppuccin.enable` and `catppuccin.flavor` options, and optionally the
`catppuccin.accent` option. `catppuccin.flavor` and `catppuccin.accent` should
default to `config.catppuccin.flavor` and `config.catppuccin.accent`, respectively.
When you're done, make sure to add your new file to the list in
`modules/<module>/all-modules.nix`

Packages can be auto-generated from our upstream sources to use in modules.
This allows us to easily access, build, and auto-update all themes reliably
across systems. You can add a new port to this collection using a script in the
`pkgs/` folder

```bash
./pkgs/paws.py port_name
```

Alternatively -- or if your port requires a build step -- you can make your own
expression with `buildCatppuccinPort`.

After creating your module, add the options to enable it in `modules/tests/`.
This will allow for your configuration to be tested along with the other
modules automatically.

<!-- This looks the best with the changelog generator. -->

Commits that add ports should be of the format

```
feat(<nixos or home-manager>): add support for <port>
```

## Commit messages

This repository uses [Conventional Commits](https://conventionalcommits.org).
Commit headers should be lowercase. Most commits should include a body that briefly
describes the motivation and content of the commit.

### Commit types

- `fix`: A bug fix that doesn't modify the public API
- `feat`: A code change that modifies the public API
- `refactor`: A code change that doesn't change behavior
- `style`: A style fix or change
- `docs`: Any change to documentation
- `ci`: Any change to CI files
- `revert`: A revert commit. The message should describe the reasoning and the
  commit should include the `Refs:` footer with the short hashes of the commits
  being reverted.
- `chore`: catch-all type

### Commit scopes

Available commit scopes are port names, `nixos`, `home-manager`, `modules`,
`pkgs`, and `tests`. If none of these apply, omit the scope.

### Breaking changes

All breaking changes should be documented in the commit footer in the format
described by Conventional Commits. Use the `<type>!` syntax in order to distinguish
breaking commits in the log, but include the footer to provide a better description
for the changelog generator.

```
feat(bar)!: foo the bars

BREAKING CHANGE: bars are now foo'ed
```

## For Maintainers

### Merging

Use squash merges when reasonable. They don't pollute the log with merge commits, and
unlike rebase merges, list the author as the committer as well.

### Creating Releases

As of v25.05, `catppuccin/nix` tries to match the upstream releases of NixOS
and home-manager. This is done through the `main` branch supporting unstable,
and the `release-*` branches matching a stable release of NixOS.

Tags are created on each new stable "branch-off" in the format of `vYY.MM`.
**These must be created from the accompanying `release-YY.MM` branch!** A
release is then created from that tag, and a changelog entry is created for all
changes since the last stable branch-off with the following
[`git-cliff`](https://git-cliff.org/) command:

```console
$ VERSION="YY.MM"
$ TAG="v${VERSION}"
$ git switch "release-${VERSION}"
$ git-cliff --github-token "$(gh auth token)" --prepend CHANGELOG.md --tag "$TAG" --unreleased
```
