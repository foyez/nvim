# NeoVim

## NeoVim Installation

- To install Rust (including Cargo)

```sh
# install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# add path to: ~/.zshrc
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.zshrc

# check version
cargo --version
```

- To install bob

```sh
cargo install bob-nvim
```

- To build & install bob from source (alternative)

```sh
# clone the bob repo
git clone https://github.com/MordechaiHadad/bob.git
cd bob

# build and install with correct features
cargo install --path . --locked

# check version
bob --version
```

- To install Neovim using `bob`

```sh
# install stable version
bob install stable

# to install specific version
bob install nightly
bob install v0.9.5

# to set default Neovim version
bob use stable

# add binary path to: ~/.zshrc
export PATH="$HOME/.local/share/bob/[version-name]/bin:$PATH"
```

- Clone neovim config

```sh
cd ~/.config
git clone git@github.com:foyez/nvim.git
nvim
```

## Fonts

- NerdFonts intallation link: https://www.nerdfonts.com/font-downloads
- Paste the fonts in `~/Library/Fonts`

## Wezterm Terminal Emulator

- Wezterm Terminal downloading link: https://wezterm.org/install/macos.html
- `$HOME/.wezterm.lua`

```lua
local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback {
{
family = 'JetBrainsMono Nerd Font',
harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
},
},
  font_size = 13.0,

  color_scheme = "Snazzy",

  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_decorations = "RESIZE",

  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  use_fancy_tab_bar = false,

  window_close_confirmation = "NeverPrompt",
}
```

## NeoVim keymaps

### 🔍 **Telescope**

| Shortcut     | Action                  |
| ------------ | ----------------------- |
| `<leader>ff` | Find files              |
| `<leader>fr` | Show recent files       |
| `<leader>fs` | Live grep (search text) |
| `<leader>fc` | Grep word under cursor  |

➡ **Plugin:** [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)

---

### 📁 **NvimTree (File Explorer)**

| Shortcut     | Action                      |
| ------------ | --------------------------- |
| `<leader>ee` | Toggle NvimTree             |
| `<leader>ef` | Toggle & focus current file |
| `<leader>ec` | Collapse all folders        |
| `<leader>er` | Refresh the tree            |
| `a`          | Create a file               |
| `d`          | Create a file               |

➡ **Plugin:** [`nvim-tree/nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)

---

### 🖥️ **vim-maximizer**

| Shortcut     | Action                 |
| ------------ | ---------------------- |
| `<leader>sm` | Toggle maximize window |

➡ **Plugin:** [`szw/vim-maximizer`](https://github.com/szw/vim-maximizer)

---

### 🧭 **Tmux Navigator**

| Shortcut   | Action                   |
| ---------- | ------------------------ |
| `Ctrl + h` | Move to left split/pane  |
| `Ctrl + j` | Move to below split/pane |
| `Ctrl + k` | Move to above split/pane |
| `Ctrl + l` | Move to right split/pane |
| `Ctrl + \` | Move to last active pane |

➡ **Plugin:** [`christoomey/vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator)

---

### 🎓 **42header**

| Shortcut     | Action                  |
| ------------ | ----------------------- |
| `:Stdheader` | Insert 42 school header |

➡ **Plugin:** [`42paris/42header`](https://github.com/42Paris/42header)

---

## 📦 General Keymaps

These aren't from plugins but are part of custom mappings:

| Shortcut         | Action                     |
| ---------------- | -------------------------- |
| `jk` (insert)    | Escape insert mode         |
| `<C-u>` (insert) | Uppercase current word     |
| `<leader>+`      | Increment number           |
| `<leader>-`      | Decrement number           |
| `x` (normal)     | Delete character (no yank) |
| `<leader>nh`     | Clear search highlight     |
| `<leader>sv`     | Split window vertically    |
| `<leader>sh`     | Split window horizontally  |
| `<leader>se`     | Equalize split sizes       |
| `<leader>sx`     | Close current split        |
| `<leader>to`     | Open new tab               |
| `<leader>tx`     | Close current tab          |
| `<leader>tn`     | Next tab                   |
| `<leader>tp`     | Previous tab               |
| `<Esc>`          | Exit terminal mode         |

---

## Wezterm shortcut keymaps

| Shortcut           | Action                              |
| ------------------ | ----------------------------------- |
| `Ctrl + Shift + T` | Open new tab                        |
| `Ctrl + Shift + W` | Close current tab                   |
| `Ctrl + Shift + [` | Previous tab                        |
| `Ctrl + Shift + ]` | Next tab                            |
| `Ctrl + Shift + N` | Spawn new window                    |
| `Alt + Enter`      | Toggle full screen                  |
| `Ctrl + Shift + R` | Reload configuration                |
| `Ctrl + Shift + P` | Show command palette (if enabled)   |
| `Ctrl + Shift + C` | Copy selected text                  |
| `Ctrl + Shift + V` | Paste from clipboard                |
| `Ctrl + Shift + F` | Search (like `Ctrl + F` in browser) |

## Shortcut keymaps of shell (e.g., Bash, Zsh, Fish)

### 🔤 Delete Word

| Shortcut   | Action                    | Shell                 |
| ---------- | ------------------------- | --------------------- |
| `Ctrl + W` | Delete word before cursor | All (bash, zsh, fish) |
| `Alt + D`  | Delete word after cursor  | All                   |

---

### 📄 Delete Line

| Shortcut   | Action                      |
| ---------- | --------------------------- |
| `Ctrl + U` | Delete to beginning of line |
| `Ctrl + K` | Delete to end of line       |
| `Ctrl + A` | Move to start of line       |
| `Ctrl + E` | Move to end of line         |

---

## VIM Keymaps

> [cheatsheet](https://vim.rtorr.com/)

## Modes

- `v` - visual mode
- `:` - command mode
- `i` - insert mode
- `esc` - back to normal mode

## Normal Mode

#### Basic Navigation

- `h` → left (going home)
- `j` → down (jumping down)
- `k` → up (kicking up)
- `l` → right
- `5k` → 5 lines up

#### Navigate by word

- `b` → Move backword by word (letters,numbers and underscores)
- `B` → Move backword by WORD (till whitespace)
- `w` → Move forward by word
- `W` → Move forward by WORD

#### Move to specific position

- `$` → Move to the end of the line
- `^` → Move to the first non-blank character of the line
- `0` → Move to the start of the line

- `ctrl+u` → page up
- `ctrl+d` → page down

- `5G` → move to 5th line

- `H` → Move to the Top of the screen (High)
- `M` → Move to the Middle of the screen (Middle)
- `L` → Move to the Low of the screen (Low)

#### Copy, Paste, Delete & Correct

- `yy` → copy line (y for yank)
- `yw` → copy token
- `yW` → copy word
- `p` → paste the last thing that was deleted or copied

- `x` → delete a character
- `r` → replace a character
- `D` or `d$` → delete rest of the line
- `C` or `c$` → delete rest of the line and insert mode
- `dd` → delete the current line
- `5dd` → delete the next 5 line
- `cw` → correct the token (delete + insert)
- `cW` → correct the word
- `cc` → correct the line

- `y%` or `d%` → copy or delete everything in matching brackets (position cursor on opening or closing bracket)
- `ci(` or `ci{` or `ci[` or `ci"` → delete texts inside the matching brackets or signs

### Undo & Redo

- `u` → undo
- `ctrl + r` → redo

### Search Commands

- `/pattern` - Search for pattern
- `n` - Jump to next match
- `N` - Search in opposite direction

### Replace Commands

- `:%s/old/new` - Replace old with new throughout the file
- `:%s/old/new/g`
- `:6,10s/old/new/g`

```
% => run this command on all lines.
6,10 => run this command on line 6 and 10
g => match multiple occurences in the same line.
```

## Insert Mode

- `i` → insert before the cursor
- `I` → insert at the beginning of the line
- `a` → insert (append) after the cursor
- `A` → insert (append) at the end of the line
- `o` → append (open) a new line below the current line
- `O` → append (open) a new line above the current line
- `Ctrl + h` - delete the character before the cursor
- `Ctrl + w` - delete word before the cursor
- `Ctrl + u` - delete everything befor the cursor
- `Ctrl + t` - indent (move right) line one shiftwidth
- `Ctrl + d` - de-indent (move left) line one shiftwidth

## Commands

- `:w` - write (save) the file, but don't exit
- `:w !sudo tee %` - write out the current file using sudo
- `:wq` or `:x` or `ZZ` - write (save) and quit
- `:q` - quit (fails if there are unsaved changes)
- `:q!` or `ZQ` - quit and throw away unsaved changes
- `!node filename.ext` - run a file
- `:wqa` - write (save) and quit on all tabs
- `:set list` - make spaces and tabs visible
- `:e newfile.txt` - create newfile.txt if it doesn't exist
- `:!mkdir -p dir` - create a directory