# Zsh without bloated plugin or theme manager

This is a configuration file for zsh on arch linux.

## Features

- Use your OS package manager and source/configure all plugins in a single file
- Case-insensitive, misspell-forgiving completions
- Emacs keybindings paired with common text editor keybindings (See [Keybindings](#keybindings))
- Convenient aliases (See [Aliases](#aliases))
- Long history with immediate history updates and duplicate omission (duplicates move to end of history)
- Commands beginning with space won't be saved in history
- Clean prompt with git status, exit code of last command if code != 0, and optionally displaying hostname
- [Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) based on history
- Search through history for previous commands matching everything up to current cursor position with arrow keys
- [Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- Autocomplete and history search with [fzf](https://github.com/junegunn/fzf) fuzzy search

## Keybindings

The default config enables Emacs keybindings but you can disable them or change them to vi by swapping out the `-e` flag with `-v` in [line 17](https://github.com/bttger/my-zsh/blob/main/.zshrc#L17). The following keybindings add features known from common text editors:

- <kbd>Home</kbd> to move cursor to the beginning of the line
- <kbd>End</kbd> to move cursor to the end of the line
- <kbd>Del</kbd> to delete the following char
- <kbd>Ctrl</kbd> + <kbd>Del</kbd> to delete the following word
- <kbd>Ctrl</kbd> + <kbd>⌫</kbd> to delete the previous word
- <kbd>Ctrl</kbd> + <kbd>→</kbd> to move cursor forward one word
- <kbd>Ctrl</kbd> + <kbd>←</kbd> to move cursor backward one word
- <kbd>Ctrl</kbd> + <kbd>Z</kbd> to undo last action
- <kbd>Ctrl</kbd> + <kbd>Y</kbd> to redo undone actions

Autosuggestions:

- <kbd>Ctrl</kbd> + <kbd>→</kbd> to partially accept suggestion up to the point that the cursor moves to
- <kbd>End</kbd> or <kbd>→</kbd> to accept suggestion and replace contents of the command line buffer with the suggestion

Fuzzy search:

- <kbd>Ctrl</kbd> + <kbd>T</kbd> to fuzzy search files/directories and paste the selected files/directories onto the command line
- <kbd>Ctrl</kbd> + <kbd>R</kbd> to fuzzy search the history and paste the selected command onto the command line
- <kbd>Alt</kbd> + <kbd>C</kbd> to fuzzy search directories and `cd` into the selected directory
- Type `**` and hit <kbd>Tab</kbd> to fuzzy search files/directories/process IDs/hostnames/environment variables, and autocomplete command

History search:

- Type beginning of some command and use <kbd>↑</kbd> and <kbd>↓</kbd> to search through the history for previous commands matching everything up to current cursor position

## Aliases

| alias     | command                                  |
| --------- | ---------------------------------------- |
| `md`      | `mkdir -p`                               |
| `rd`      | `rmdir`                                  |
| `t`       | `tere --filter-search`                   |
| `hib`     | `systemctl hibernate`                    |
| `ls`      | prettified `lsd`                         |
| `glog`    | prettified `git log`                     |
| `adog`    | prettified `git log`                     |
| `ddc`     | change backlight brightness              |
| `histctx` | find stuff in shell history with context |
| `~`       | `cd "$HOME"`\*                           |
| `-`       | `cd "$OLDPWD"`\*                         |
| `..`      | `cd ..`\*                                |
| `....`    | `cd ../..`\*                             |
| `......`  | `cd ../../..`\*                          |

\*Set by the `autocd` option.


## Install

### On Arch Linux

```sh
# Install zsh and some plugins
pacman -S zsh zsh-completions zsh-autosuggestions fzf zsh-syntax-highlighting xclip

# Install the following plugin from AUR using helper like yay or build yourself
git-prompt.zsh

# Steps to build
git clone https://aur.archlinux.org/git-prompt.zsh.git
cd git-prompt.zsh
makepkg -sri

# Make Zsh your default shell
chsh -s $(which zsh)

# Create or update your ~/.zshrc according to the config in this repository
# The .zshrc file usually resides in your home directory
# After making changes to your config, update your running Zsh instance
source ~/.zshrc
```
