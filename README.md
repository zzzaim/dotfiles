Dotfiles
========

This is [Zaim's](https://github.com/zzzaim) dotfiles. It is organized and
installed using [GNU Stow](https://www.gnu.org/software/stow/) through an
[install.sh](install.sh) script that has some minimal custom rules and
conventions.

## Install

```shell
$ git clone https://github.com/zzzaim/dotfiles.git
$ dotfiles/install.sh
```

This will use Stow to symlink dotfiles into $HOME.

## Packages

As per GNU Stow convention, each directory in this repo is a *package*:

> a related collection of files and directories that you wish to
> administer as a unit.

Package          | Description
---------------- | -----------
[bash](bash)     | Base bash configs, scripts
[bin](bin)       | General utilities
[colors](colors) | Shell color scheme scipts ([base16](https://github.com/chriskempson/base16-shell))
[git](git)       | Git config
[nvm](nvm)       | Node version manager
[ssh](ssh)       | SSH config / utils
[tmux](tmux)     | Tmux config / utils
[vim](vim)       | vim config

### Package structure

A package is organized using a conventional folder structure.

Folder       | Description
------------ | -----------
`bin/`       | Used for programs and scripts. Example: [tmux/bin/startmux](tmux/bin/strartmux)
`.bashrc.d/` | Used to add custom scripts to `.bashrc`. Example: [nvm/.bashrc.d](nvm/.bashrc.d). Prefix files with a number to control source ordering.

### Package managing

If a package contains a `.stow-skip` file in its root directory, `install.sh`
will not install that package.

If a package contains a `.stow-disabled` file in its root directory,
`install.sh` will uninstall it from $HOME.

## Testing

There is a simple unit test in `.test`, which tests the custom `install.sh`
script rules:

```shell
$ ./.test/test.sh
Running tests in ./.test/test.sh
Running test_disabled... SUCCESS ✓
Running test_disabled_none... SUCCESS ✓
Running test_installed... SUCCESS ✓
Running test_skip... SUCCESS ✓
```

## Links

- [GitHub does dotfiles](https://dotfiles.github.io/): links to other dotfile repos, utils, frameworks.
- [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles): A curated list of dotfiles resources.
- [GNU Stow](https://www.gnu.org/software/stow/): a symlink farm manager.
