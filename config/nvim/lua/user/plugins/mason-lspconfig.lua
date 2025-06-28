return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "intelephense",
        "jsonls",
        "lua_ls",
        "omnisharp",
        "phpactor",
        "sqlls",
        "ts_ls",
        "vimls",
        -- "volar",
        "yamlls"
        -- "cssls",
        -- "git??",
        -- "pyright",
      },
      automatic_installation = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
