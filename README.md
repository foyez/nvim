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

## NeoVim shorcut keymaps

### 🔧 **Insert Mode**

| Shortcut   | Action                 |
| ---------- | ---------------------- |
| `jk`       | Escape insert mode     |
| `Ctrl + u` | Uppercase current word |

---

### 🔧 **Normal Mode**

#### 🧹 General

| Shortcut     | Action                            |
| ------------ | --------------------------------- |
| `<leader>nh` | Clear search highlights (`:nohl`) |
| `x`          | Delete character without yanking  |
| `<leader>+`  | Increment number (`<C-a>`)        |
| `<leader>-`  | Decrement number (`<C-x>`)        |

#### 🪟 Window Management

| Shortcut     | Action                         |
| ------------ | ------------------------------ |
| `<leader>sv` | Split window vertically        |
| `<leader>sh` | Split window horizontally      |
| `<leader>se` | Make splits equal size         |
| `<leader>sx` | Close current split (`:close`) |

#### 🗂️ Tab Management

| Shortcut     | Action                          |
| ------------ | ------------------------------- |
| `<leader>to` | Open new tab (`:tabnew`)        |
| `<leader>tx` | Close current tab (`:tabclose`) |
| `<leader>tn` | Next tab (`:tabn`)              |
| `<leader>tp` | Previous tab (`:tabp`)          |

#### 🖥️ Plugin: Maximizer

| Shortcut     | Action                 |
| ------------ | ---------------------- |
| `<leader>sm` | Toggle maximize window |

#### 🌳 Plugin: NvimTree

| Shortcut     | Action                                 |
| ------------ | -------------------------------------- |
| `<leader>ee` | Toggle NvimTree                        |
| `<leader>ef` | Toggle NvimTree and focus current file |
| `<leader>ec` | Collapse NvimTree folders              |
| `<leader>er` | Refresh NvimTree                       |

#### 🔍 Plugin: Telescope

| Shortcut     | Action                       |
| ------------ | ---------------------------- |
| `<leader>ff` | Find files                   |
| `<leader>fr` | Open recent files            |
| `<leader>fs` | Live grep (search by string) |
| `<leader>fc` | Search word under cursor     |

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