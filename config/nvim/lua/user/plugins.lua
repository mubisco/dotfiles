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
  -- use { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" }
  -- use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }
  -- use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
  -- use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }
  -- use { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" }
	-- use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  -- use { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" }
  -- use { "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" }
  -- use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
  -- use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  -- use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  -- use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }
	-- use {"folke/which-key.nvim"}

  -- Colorschemes
  use "lunarvim/colorschemes"
  -- use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  -- use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }
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
	-- use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  -- use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

	-- Telescope
	 use "nvim-telescope/telescope.nvim"
   -- Install telescope-media-files

	-- Treesitter
	-- use {
		-- "nvim-treesitter/nvim-treesitter",
		-- commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
	-- }

	-- Git
-- use { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" }
-- "Linting
-- Plug 'w0rp/ale'

-- "Airline
-- Plug 'vim-airline/vim-airline'
-- Plug 'vim-airline/vim-airline-themes'
-- Plug 'airblade/vim-gitgutter'
-- Plug 'Yggdroot/indentLine'
-- Plug 'tpope/vim-fugitive'
-- Plug 'tommcdo/vim-fubitive'
-- Plug 'ap/vim-css-color'
-- Plug 'junegunn/fzf'
-- Plug 'junegunn/fzf.vim'
-- "Plug 'TaDaa/vimade'
-- Plug 'SirVer/ultisnips'

-- "Autocompletion
-- Plug 'neoclide/coc.nvim', {'branch': 'release'}

-- " PHP Development
-- Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
-- Plug 'StanAngeloff/php.vim', {'for': 'php'}
-- Plug 'lumiliet/vim-twig'
-- Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
-- Plug 'vim-vdebug/vdebug'

-- " Javascript Development
-- Plug 'pangloss/vim-javascript'
-- Plug 'posva/vim-vue'
-- Plug 'mxw/vim-jsx'
-- Plug 'leafgarland/typescript-vim'
-- Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

-- " Uuid Generator
-- Plug 'kburdett/vim-nuuid'

-- " Csv Files
-- Plug 'chrisbra/csv.vim'

-- " Pug
-- Plug 'digitaltoad/vim-pug'

-- " Themes
-- Plug 'k4yt3x/ayu-vim-darker'
-- Plug 'Siphalor/vim-atomified'
-- Plug 'tomasiser/vim-code-dark'
-- Plug 'trusktr/seti.vim'
-- Plug 'patstockwell/vim-monokai-tasty'
-- Plug 'nanotech/jellybeans.vim' , {'as': 'jellybeans'}
-- Plug 'chuling/vim-equinusocio-material'
-- Plug 'jaredgorski/spacecamp'
-- Plug 'arcticicestudio/nord-vim'
-- Plug 'sainnhe/sonokai'
-- Plug 'kyoz/purify', { 'rtp': 'vim' }
-- Plug 'morhetz/gruvbox'

-- "Tags
-- Plug 'ludovicchabant/vim-gutentags'

-- "Markdown
-- Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
-- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
-- Plug 'ryanoasis/vim-devicons'

-- "Kitty
-- Plug 'fladson/vim-kitty'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

