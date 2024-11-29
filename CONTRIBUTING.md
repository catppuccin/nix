# Contributing

## Adding a port

Create a file in `modules/<module>/` with the name of the port. All ports should have 
the `catppuccin.enable` and `catppuccin.flavor` options, and optionally the
`catppuccin.accent` option. `catppuccin.flavor` and `catppuccin.accent` should
default to `config.catppuccin.flavor` and `config.catppuccin.accent`, respectively.
When you're done, make sure to add your new file to the list in
`modules/<module>/all-modules.nix`

[npins](https://github.com/andir/npins) is used to track our upstream
sources to use in modules. This allows us to easily access and auto-update all themes.
You can add a new repository using a script in our subflake

```bash
nix run ./dev#add-source -- port_name branch_if_not_main
```
Alternatively, you can run `npins add github --directory .sources` manually

After creating your module, add the options to enable it in `test.nix` under the
`nodes.machine` attrset. This will allow for your configuration to be tested along
with the other modules in a VM automatically.

<!-- This looks the best with the changelog generator. -->
Commits that add ports should be of the format

```
feat(<nixos or home-manager>): add support for <port>
```

> **Note**
> Unofficial ports will not be accepted; all sources must be from the
> [Catppuccin](https://github.com/catppuccin) GitHub organization

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

Use squash merges when reasonable. They don't pollute the log with merge commits, and
unlike rebase merges, list the author as the committer as well.
