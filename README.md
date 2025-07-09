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

