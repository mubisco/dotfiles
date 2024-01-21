local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use { "phpactor/phpactor", run = "composer install", ft = "php"}
  use { "rest-nvim/rest.nvim", requires = {"nvim-lua/plenary.nvim"} }
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "kburdett/vim-nuuid" } -- Uuuid generator
  use { "chrisbra/csv.vim" } -- Improve Csv visualization
  -- use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
  -- use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  -- use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  use { "goolord/alpha-nvim" }
  use {"folke/which-key.nvim"}

  -- Cmp 
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim"
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { "jose-elias-alvarez/nvim-lsp-ts-utils"}
  use { "RRethy/vim-illuminate" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }
  use { "tpope/vim-fugitive" }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  -- Install telescope-media-files

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  -- Debugger
  use {'mfussenegger/nvim-dap'}
  use {'theHamsta/nvim-dap-virtual-text'}
  use {"rcarriga/nvim-dap-ui"}

  -- Tests
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-phpunit",
      "nvim-neotest/neotest-go",
      "marilari88/neotest-vitest"
    }
  }

  -- Colorschemes
  use "lunarvim/colorschemes"
  use { "folke/tokyonight.nvim" }
  -- use 'k4yt3x/ayu-vim-darker'
  use 'Siphalor/vim-atomified'
  -- use 'tomasiser/vim-code-dark'
  -- use 'trusktr/seti.vim'
  use 'patstockwell/vim-monokai-tasty'
  use 'nanotech/jellybeans.vim'
  -- use 'chuling/vim-equinusocio-material'
  use 'sainnhe/sonokai'
  -- Plug 'kyoz/purify', { 'rtp': 'vim' }
  -- use 'morhetz/gruvbox'


  -- "Tags
  -- Plug 'ludovicchabant/vim-gutentags'

  -- "Markdown
  -- Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

  -- "Kitty
  -- Plug 'fladson/vim-kitty'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

