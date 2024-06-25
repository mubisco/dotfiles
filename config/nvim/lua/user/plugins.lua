local fn = vim.fn

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--
-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
lazy.setup({
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  { "phpactor/phpactor", build = "composer install", ft = "php"},
  -- { "rest-nvim/rest.nvim", dependencies = {"nvim-lua/plenary.nvim"} },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  -- {
  --   "rest-nvim/rest.nvim",
  --   ft = "http",
  --   dependencies = { "luarocks.nvim" },
  --   config = function()
  --     require("rest-nvim").setup()
  --   end
  -- },
  { "numToStr/Comment.nvim" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "nvim-tree/nvim-web-devicons", lazy = false },
  { "mubisco/idx.nvim", opts = { disableKeymaps = false } },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy= false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function ()
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        renderer = {
          root_folder_modifier = ":t",
          -- icons = {
          --   glyphs = {
          --     default = "",
          --     symlink = "",
          --     folder = {
          --       arrow_open = "",
          --       arrow_closed = "",
          --       default = "",
          --       open = "",
          --       empty = "",
          --       empty_open = "",
          --       symlink = "",
          --       symlink_open = "",
          --     },
          --     git = {
          --       unstaged = "",
          --       staged = "S",
          --       unmerged = "",
          --       renamed = "➜",
          --       untracked = "U",
          --       deleted = "",
          --       ignored = "◌",
          --     },
          --   },
          -- },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "󰉀",
            info = "",
            warning = "",
            error = "",
          },
        },
        view = {
          width = 40,
          side = "left",
        }
      }
    end
  },
  { "akinsho/bufferline.nvim" },
  { "moll/vim-bbye" },
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/toggleterm.nvim" },
  -- { "kburdett/vim-nuuid" }, -- Uuuid generator
  { "chrisbra/csv.vim" }, -- Improve Csv visualization
  -- use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
  -- use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  -- use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  { "goolord/alpha-nvim" },
  {"folke/which-key.nvim"},

  -- Cmp 
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",

  -- Snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim",
  "nvimtools/none-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "RRethy/vim-illuminate",

  -- Git
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",

  -- Telescope
  "nvim-telescope/telescope.nvim",
  -- Install telescope-media-files

  -- Treesitter
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

  -- Debugger
  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  {"rcarriga/nvim-dap-ui", dependencies={"nvim-neotest/nvim-nio"}},

  -- Tests
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-phpunit",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest"
    }
  },

  -- Colorschemes
  "lunarvim/colorschemes",
  "folke/tokyonight.nvim",
  "loctvl842/monokai-pro.nvim",
  'Siphalor/vim-atomified',
  'patstockwell/vim-monokai-tasty',
  'nanotech/jellybeans.vim',
  'sainnhe/sonokai',
})

