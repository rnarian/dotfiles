# dotfiles

Setup for my work and private MacBook: zsh, git, vim, Ghostty and mise config, plus CLI tools and apps. The only requirement is [Homebrew](https://brew.sh).

## Install

```bash
git clone git@github.com:rnarian/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh            # work MacBook
~/.dotfiles/install.sh private    # private MacBook
```

Sign in to the App Store app first, or the App Store apps fail to install.

`install.sh` is safe to run again. It:

1. Links every file in `home/` to `~/.<path>`, for example `home/zshrc` → `~/.zshrc` and `home/config/mise/config.toml` → `~/.config/mise/config.toml`. A real file in the way is renamed to `<file>.backup`.
2. Installs everything in `Brewfile`, and with `private` also `Brewfile.private`. Apps you installed by hand are taken over by Homebrew, not downloaded again.
3. Installs node, pnpm and bun with mise.

After a change, run `dotfiles` or `dotfiles private` (an alias for `install.sh`).

## macOS settings

`macos.sh` sets key repeat, trackpad and text substitution settings. `install.sh` doesn't run it, because it changes system settings. Run it by hand:

```bash
~/.dotfiles/macos.sh
```

## Files

| Path | Contents |
| --- | --- |
| `home/` | Dotfiles, linked into `~` |
| `Brewfile` | CLI tools and apps for both Macs |
| `Brewfile.private` | Apps for the private Mac only |
| `macos.sh` | macOS settings |

## Remove packages

Delete the line from the Brewfile, then list what is installed but not in the Brewfiles:

```bash
brew bundle cleanup --formula --cask --tap --file=Brewfile                              # work
cat Brewfile Brewfile.private | brew bundle cleanup --formula --cask --tap --file=-     # private
```

Add `--force` to uninstall what it lists. Keep `--formula --cask --tap`: without them, cleanup also uninstalls App Store apps that aren't in a Brewfile, such as Outlook.

## License

[MIT](LICENSE)
