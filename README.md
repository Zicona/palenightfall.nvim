# 🌑 Palenightfall

<!-- ## ![](https://user-images.githubusercontent.com/9450943/132907523-7033ec1d-281e-418c-907c-1f2de2d4b7c6.png) -->

Fork of JoosepAlviste's palenightfall.nvim.
What i used as inspiration :

- Sebastian Lague's colorscheme
- Palenight Theme on vscode
- Dainty's Material Theme Palenight on vscode

## ⚡️ Requirements

- Neovim >= 0.5.0


## 📦 Installation

Install with your favorite plugin manager:

```lua
use 'Zicona/palenightfall.nvim'
```


## 🚀 Usage

In Vimscript:

```vim
colorscheme palenightfall
```

Or in Lua:

```lua
require('palenightfall').setup()
```


## 🌯 Supported plugins

- [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)
- [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
- [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)
- [`folke/noice.nvim`](https://github.com/folke/noice.nvim)
- [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
- [`tamago324/lir.nvim`](https://github.com/tamago324/lir.nvim)
- [`L3MON4D3/LuaSnip`](https://github.com/L3MON4D3/LuaSnip)
- [`rcarriga/nvim-notify`](https://github.com/rcarriga/nvim-notify)
- [`kyazdani42/nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)
- [`preservevim/vim-markdown`](https://github.com/preservim/vim-markdown)
- [`tpope/vim-fugitive`](https://github.com/tpope/vim-fugitive)
- I also added links for lsp semantic tokkens for nvim-lspconfig, still checking how it does

## ⚙️ Configuration

A transparent background can be enabled with:

```lua
require('palenightfall').setup({
  transparent = true,
})
```

Any colors and highlights can be overridden in Lua with the `setup` function:

```lua
require('palenightfall').setup({
  color_overrides = {
    cyan = '#fff0000',
  },
  highlight_overrides = {
    -- Check the exact highlight configuration format from the code
    Normal = { fg = '#ff0000' },
  },
})
```

There are also explicit functions for overriding either the colors or the 
highlights:

```lua
require('palenightfall').configure_colors({
  cyan = '#fff0000',
})
require('palenightfall').configure_highlights({
  Normal = { fg = '#ff0000' },
})

-- Make sure to call `.setup()` *after* configuration
require('palenightfall').setup()
```

You can access the colors if you would like to use them in your own 
customizations:

```lua
local colors = require('palenightfall').colors

require('palenightfall').setup({
  highlight_overrides = {
    Normal = { fg = colors.cyan },
  },
})
```

> See [`lua/palenightfall/init.lua`](lua/palenightfall/init.lua) for the default colors and highlights.


## 📸 More screenshots

No screenshot yet.
<!-- ![](https://user-images.githubusercontent.com/9450943/213641206-e26f2f59-2519-408a-882b-ff0675830dbe.png) -->
