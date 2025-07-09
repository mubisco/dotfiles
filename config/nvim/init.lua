local function loadrequire(module)
    local function requiref(module)
        require(module)
    end
    pcall(requiref,module)
end
loadrequire("override.user.mapleader")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.keymaps"
require "user.lazy"
require "user.alpha"
require "user.theme-monokai-pro"
require "user.cmp"
require "user.lsp"
require "user.toggleterm"
require "user.autocommands"
require "user.dap"

loadrequire("override.init")

-- luarocks
-- nvim-nio
-- lua-curl
