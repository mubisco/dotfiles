-- Vim Monokay Tasty Values
--local colorscheme = "vim-monokai-tasty"
-- vim.g.vim_monokai_tasty_italic = 1
-- vim.g.vim_monokai_tasty_machine_tint = 1

-- Jellybeans
-- local colorscheme = "jellybeans"
-- vim.g.jellybeans_use_term_italics = 1

-- Sonokai
--[[
local colorscheme = "sonokai"
vim.g.sonokai_style = "espresso"
vim.g.sonokai_enable_italic = 1
]]
local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!!")
  return
end
