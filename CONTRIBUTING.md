# Contributing

## Adding a port

Create a file in `modules/<module>/` with the name of the port. Add the file to the
`imports` declaration in `modules/<module>/default.nix`. All ports should have the
`catppuccin.enable` and `catppuccin.flavour` options, and optionally the
`catppuccin.accent` option. `catppuccin.flavour` and `catppuccin.accent` should
default to `config.catppuccin.flavour` and `config.catppuccin.accent`, respectively.

<!-- This loooks the best with the changelog generator. -->
Commits that add ports should be of the format `feat(modules): add support for <port>`.

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
  commit should include the `Refs:` header with the short hashes of the commits
  being reverted.
- `chore`: catch-all type

### Commit scopes

Available commit scopes are port names and `modules`. If neither of these apply,
omit the scope.

### Breaking changes

All breaking changes should be documented in the commit footer in the format
described by Conventional Commits. Use the `<type>!` syntax in order to distinguish
breaking commits in the log, but include the footer to provide a better description
for the changelog generator.

```
feat(bar)!: foo the bars

BREAKING CHANGE: bars are now foo'ed
```
