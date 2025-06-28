return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        -- "cssls",
        "dockerls",
        "eslint",
        -- "git??",
        "gopls",
        "html",
        "intelephense",
        "jsonls",
        "lua_ls",
        "omnisharp",
        "phpactor",
        -- "pyright",
        "rust_analyzer",
        "sqlls",
        "ts_ls",
        "vimls",
        -- "volar",
        "yamlls"
      },
      automatic_installation = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
