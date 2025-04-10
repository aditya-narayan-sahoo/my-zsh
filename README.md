# Zsh Configuration without Bloat

This is a minimal Zsh configuration for Arch Linux, optimized for speed and usability, without any bloated plugin or theme managers. It integrates useful features for a smooth terminal experience, all in a single config file.

## Features

- **No bloat**: Manage all plugins via your OS package manager, sourcing and configuring everything in a single file.
- **Smart completions**: Case-insensitive, misspelled command completions.
- **Keybindings**: Emacs-style keybindings with additional text editor-style controls. (See [Keybindings](#keybindings)).
- **Convenient Aliases**: Predefined, useful aliases to speed up your workflow. (See [Aliases](#aliases)).
- **History management**: Long history with immediate updates and duplicate removal (duplicates move to the end).
- **History exclusion**: Commands starting with a space won't be saved to history.
- **Clean prompt**: Displays Git status, exit code (if non-zero), and optionally, your hostname.
- **[Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**: Suggest commands based on your history.
- **History search**: Search through your history with arrow keys for previously executed commands.
- **[Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**: Visual cues for valid syntax.
- **Fuzzy Search**: Use [fzf](https://github.com/junegunn/fzf) for advanced fuzzy searching in history, files, directories, and commands.
- [tere](https://github.com/mgunyho/tere) integration for easy and fast directory navigation

---

## Keybindings

By default, Emacs keybindings are enabled, but you can easily switch to **Vi keybindings** by modifying the `-e` flag to `-v` on [line 20](https://github.com/aditya-narayan-sahoo/my-zsh/blob/main/.zshrc#L20). These keybindings include features from common text editors:

### General Editing:

- **Home**: Move cursor to the beginning of the line.
- **End**: Move cursor to the end of the line.
- **Del**: Delete the character under the cursor.
- **Ctrl + Del**: Delete the following word.
- **Ctrl + ⌫**: Delete the previous word.
- **Ctrl + →**: Move cursor forward by one word.
- **Ctrl + ←**: Move cursor backward by one word.
- **Ctrl + Z**: Undo the last action.
- **Ctrl + Y**: Redo the last undone action.

### Autosuggestions:

- **Ctrl + →**: Accept part of the autosuggestion up to the cursor position.
- **End** or **→**: Accept the entire autosuggestion and replace the command buffer with it.

### History Search:

- Type the beginning of a previous command and use **↑** or **↓** to search through your history for matching commands.

### Fuzzy search:

- Ctrl + T to fuzzy search files/directories and paste the selected files/directories onto the command line
- Ctrl + R to fuzzy search the history and paste the selected command onto the command line
- Alt + C to fuzzy search directories and cd into the selected directory
- Type \*\* and hit Tab to fuzzy search files/directories/process IDs/hostnames/environment variables, and autocomplete command

---

## Aliases

Here's a list of useful aliases included in the configuration:

| Alias    | Command                                |
| -------- | -------------------------------------- |
| `md`     | `mkdir -p`                             |
| `rd`     | `rm -rf`                               |
| `glog`   | Pretty print `git log`                 |
| `adog`   | Another alias for prettified `git log` |
| `big`    | Sort installed packages a/c size (MB)  |
| `~`      | `cd "$HOME"`\*                         |
| `-`      | `cd "$OLDPWD"`\*                       |
| `..`     | `cd ..`\*                              |
| `....`   | `cd ../..`\*                           |
| `......` | `cd ../../..`\*                        |

Also has aliases for updating the pacman mirrorlist

## Installation

### On Arch Linux

1. **Install Zsh and Plugins**

   ```
   sudo pacman -S zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting expac micro reflector tere fzf
   ```

2. **Install the Git prompt plugin from AUR Using aur helpers**

   ```
   yay -S git-prompt.zsh
   ```

3. **Or manually build it from AUR**

   ```
   git clone https://aur.archlinux.org/git-prompt.zsh.git && cd git-prompt.zsh && makepkg -sri
   ```

4. **Set Zsh as Default Shell**

   ```bash
   chsh -s $(which zsh)
   ```

5. **Configure Zsh**

   Create or update your `~/.zshrc` file according to the configuration in this repository. After updating, reload your Zsh configuration:

   ```bash
   source ~/.zshrc
   ```

---

## Credits & Links

- [Git Prompt for Zsh](https://aur.archlinux.org/packages/git-prompt.zsh)
- [Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [Zsh Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Original Repository for Config](https://github.com/bttger/my-zsh)
