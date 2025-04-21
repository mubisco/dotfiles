local function loadrequire(module)
    local function requiref(module)
        require(module)
    end
    pcall(requiref,module)
end

loadrequire("user.override.mapleader")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.keymaps"
require "user.lazy"
require "user.theme-monokai-pro"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.lualine"
require "user.toggleterm"
require "user.alpha"
require "user.autocommands"
require "user.dap"
require "user.neotest"

loadrequire("user.override.init")

-- luarocks
-- nvim-nio
-- lua-curl
