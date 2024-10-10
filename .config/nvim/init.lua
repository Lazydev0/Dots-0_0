-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd("colorscheme github_dark_high_contrast")
vim.cmd([[highlight Normal guibg=#020306 ctermbg=NONE  
highlight NormalNC guibg=#020306 ctermbg=NONE  ]])
vim.o.guifont = "Fira Code:h11"
vim.opt.termguicolors = true
require("nvim-highlight-colors").setup({
  render = "virtual", -- Set render style to 'virtual' to enable virtual symbols

  -- Customize virtual symbol
  virtual_symbol = "■",
  virtual_symbol_prefix = "",
  virtual_symbol_suffix = " ",
  virtual_symbol_position = "inline",

  -- Highlighting options
  enable_hex = true,
  enable_short_hex = true,
  enable_rgb = true,
  enable_hsl = true,
  enable_var_usage = true,
  enable_named_colors = true,
  enable_tailwind = false,
})
