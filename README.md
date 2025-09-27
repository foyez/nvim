# NeoVim

## NeoVim Installation

<details>
<summary>View contents</summary>

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

</details>

## Fonts

- NerdFonts intallation link: https://www.nerdfonts.com/font-downloads
- Paste the fonts in `~/Library/Fonts`

## Wezterm Terminal Emulator

<details>
<summary>View contents</summary>

- Wezterm Terminal downloading link: https://wezterm.org/install/macos.html
- `$HOME/.wezterm.lua` or `$HOME/.config/wezterm/wezterm.lua`

```lua
local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback {
    {
      family = 'JetBrainsMono Nerd Font',
      harfbuzz_features = {
              "calt=1", -- enable standard ligatures (arrows)
              "clig=0", -- disable contextual ligatures
              "liga=0", -- disable contextual alternatives
      },
    },
    -- Add more fallback fonts here if needed
  },
  font_size = 15.0,
  color_scheme = "Snazzy",

  audible_bell = "Disabled",

  -- Transparency
  window_background_opacity = 0.95,
  text_background_opacity = 1.0,

  -- Tab bar settings
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  -- Window appearance
  window_decorations = "RESIZE",
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  -- Window close confirmation
  window_close_confirmation = "NeverPrompt",
}
```

- C/C++ LSP Setup (clangd)
  - Download the clangbinary: https://github.com/foyez/cpp/tree/main/lsp/clangd-llvm/bin
  - Put it in: `~/clangd-llvm/bin/`
  - Add the path in `~/.zshrc`: `export PATH="$HOME/clangd-llvm/bin:$PATH"`

</details>

## NeoVim keymaps

Here's a clean and organized table of your Neovim keymaps with shortcut keys and their descriptions:

---

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

#### 🧭 Navigation

| Shortcut         | Action                                         |
| ---------------- | ---------------------------------------------- |
| `gd`             | Go to definition (LSP-aware if using `clangd`) |
| `<C-o>`          | Jump back to previous cursor position          |
| `<C-i>`          | Jump forward (after going back)                |
| `<C-^>` or `:e#` | Toggle to the previous file                    |

#### 🖥️ Plugin: Maximizer

| Shortcut     | Action                 |
| ------------ | ---------------------- |
| `<leader>sm` | Toggle maximize window |

➡ **Plugin:** [`szw/vim-maximizer`](https://github.com/szw/vim-maximizer)

#### 🌳 Plugin: NvimTree (File Explorer)

| Shortcut     | Action                                                    |
| ------------ | --------------------------------------------------------- |
| `<leader>ee` | Toggle NvimTree                                           |
| `<leader>ef` | Toggle NvimTree and focus current file                    |
| `<leader>ec` | Collapse NvimTree folders                                 |
| `<leader>er` | Refresh NvimTree                                          |
| `a`          | Create a file (`e.g.` `dir/file.txt`, `dir/`, `file.txt`) |
| `d`          | Delete a file                                             |
| `r`          | Rename a file                                             |

➡ **Plugin:** [`nvim-tree/nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)

#### 🔍 Plugin: Telescope

| Shortcut     | Action                       |
| ------------ | ---------------------------- |
| `<leader>ff` | Find files                   |
| `<leader>fr` | Open recent files            |
| `<leader>fs` | Live grep (search by string) |
| `<leader>fc` | Search word under cursor     |

➡ **Plugin:** [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)

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

---

## 🔀 Modes

* `v` → **Visual mode** (select text)
* `i` → **Insert mode**
* `:` → **Command mode**
* `Esc` → back to **Normal mode**

---

## 🚀 Normal Mode

### Navigation

* **Characters & Lines**

  * `h` ← left (home)
  * `l` → right
  * `j` ↓ down
  * `k` ↑ up
  * `5j` / `5k` → move 5 lines down/up

* **Words & WORDS**

  * **word** = till letters, numbers, and unserscores
  * **WORD** = till whitespace
  * `w` / `W` → beginning of next word / WORD
  * `e` / `E` → end of current/next word / WORD
  * `b` / `B` → beginning of current/previous word / WORD

* **Lines**

  * `0` → start of line
  * `^` → first non-blank char
  * `$` → end of line

* **Screens**

  * `Ctrl-u` → half-page up
  * `Ctrl-d` → half-page down
  * `Ctrl-b` → page back
  * `Ctrl-f` → page forward
  * `H` / `M` / `L` → top / middle / bottom of screen

* **Paragraphs & File**

  * `{` / `}` → prev/next paragraph
  * `gg` / `G` → top / bottom of file
  * `:{n}` / `{n}G` → go to line n

---

### Jump List & Navigation

* `Ctrl-o` → jump **backward** (older position)
* `Ctrl-i` → jump **forward** (newer position)
* `''` → jump to line of last cursor position
* ` `` ` → jump to exact last cursor position

👉 **Pro tip:** Think of `Ctrl-o`/`Ctrl-i` as **Back/Forward buttons** in a browser.

---

### Lookups & Tags

* `K` → open keyword documentation (e.g. man page or `:help`)
* `gd` → go to local declaration
* `gD` → go to global declaration
* `Ctrl-]` → jump to tag under cursor
* `Ctrl-t` → jump back from tag

---

### Copy / Paste / Delete / Change

* `yy` / `Y` → yank line
* `yw` / `yW` → yank word / WORD
* `p` / `P` → paste after / before
* `dd` / `5dd` → delete line(s)
* `cw` / `cW` → change from cursor to end of the word / WORD
* `cb` / `cB` → change from cursor to beginning of the word / WORD
* `caw` / `caW`  → change entire word / WORD
* `cc` → change line

👉 **Pro tip:** `y3w` → yank 3 words, `d5W` → delete 5 WORDs, `c2e` → change until end of second word, `v4e` → visually select up to the end of the fourth word

---

### Indentation

* `>>` / `<<` → indent / de-indent line
* `>` / `<` in Visual mode → indent selection
* `=` → auto-indent selection (use `gg=G` for entire file)

---

### Undo & Redo

* `u` → undo
* `Ctrl-r` → redo

---

### Repeat

* `.` → repeat last command
* `@:` → repeat last command-line command

---

### Marks

* `ma` → mark cursor as `a`
* `'a` → jump to mark `a` (line)
* `` `a `` → jump to mark `a` (exact column)
* ` `` ` → jump back to last position

---

### Buffers & Windows

* `:ls` → list buffers
* `:b{n}` → go to buffer {n}
* `:bd` → close buffer
* `:new` / `:vnew` → split
* `Ctrl-w h/j/k/l` → move between splits
* `gt` / `gT` → next / prev tab

---

### Search & Replace

* `/pattern` → search forward

* `n` / `N` → next/prev match

* `*` → search word under cursor forward

* `#` → search word under cursor backward

* `:%s/old/new/g` → replace all

* `:6,10s/old/new/g` → replace in lines 6–10

---

## ✍️ Insert Mode

* `i` / `I` → insert before cursor / at start of line
* `a` / `A` → append after cursor / at end of line
* `o` / `O` → new line below / above
* `Ctrl-h` → delete previous char
* `Ctrl-w` → delete previous word
* `Ctrl-u` → delete to line start
* `Ctrl-t` / `Ctrl-d` → indent / de-indent line

---

## ⚙️ Commands

* `:w` → save
* `:q` → quit
* `:wq` / `:x` / `ZZ` → save + quit
* `:q!` / `ZQ` → quit without saving
* `:wqa` → save + quit all

---

## ⚡ Power Moves

* `%` → jump to matching bracket
* `g;` / `g,` → jump to older/newer change
* `Ctrl-g` → show file + cursor position info
* `:noh` → clear search highlights

---

## Resources

- ThePrimeagen NVIM: [github](https://github.com/ThePrimeagen/init.lua), [playlist](https://www.youtube.com/playlist?list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)
- [devaslife NVIM](https://www.youtube.com/watch?v=fFHlfbKVi30)
- [TJ DeVries core NVIM contributor](https://www.youtube.com/watch?v=m8C0Cq9Uv9o)
- [NvChad NVIM](https://www.youtube.com/watch?v=Mtgo-nP_r8Y)
- [NVIM setup with detail explanation](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn)
- [NVIM setup in short vidoe](https://www.youtube.com/watch?v=N93cTbtLCIM)
- [In depth nvim setup](https://www.youtube.com/watch?v=6pAG3BHurdM)
- [Andrew Courter NVIM](https://github.com/exosyphon/nvim)