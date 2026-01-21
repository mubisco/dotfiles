vim.opt.background = "dark"

require("monokai-nightasty").load({
  -- You can add your options here, for example:
  -- dark_style_background = "default", -- default, dark, transparent, #color
  -- light_style_background = "default", -- default, dark, transparent, #color
  -- color_headers = false, -- Enable header colors for each header level (h1, h2, etc.)
  -- lualine_bold = true, -- Lualine a and z sections font width
  -- lualine_style = "default", -- "dark", "light" or "default" (default follows dark/light style)
  -- markdown_header_marks = false, -- Add headers marks highlights (the `#` character) to Treesitter highlight query
  
  -- Example with some options:
  -- terminal_colors = true,
  -- styles = {
  --   comments = { italic = true },
  --   keywords = { italic = true },
  --   functions = {},
  --   variables = {},
  -- },
})
