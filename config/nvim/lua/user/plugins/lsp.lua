return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "bashls",
            "dockerls",
            "eslint",
            "gopls",
            "html",
            -- "intelephense",
            "jsonls",
            "lua_ls",
            "omnisharp",
            "phpactor",
            "rust_analyzer",
            "sqlls",
            "texlab",
            "ts_ls",
            "vimls",
            "vue_ls",
            "yamlls",
          },
          automatic_installation = true,
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local handlers = require("user.lsp.handlers")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      handlers.setup()

      local servers = {}

      --[[
      servers.intelephense = {
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        root_markers = { "composer.json", ".git" },
        settings = {
          intelephense = {
            files = {
              maxSize = 5000000,
              exclude = {
                "**/.git/**",
                "**/.svn/**",
                "**/.hg/**",
                "**/CVS/**",
                "**/.DS_Store/**",
                "**/node_modules/**",
                "**/bower_components/**",
                "**/vendor/**/{Tests,tests}/**",
                "**/.history/**",
                "**/vendor/**/vendor/**",
                "**/var/**",
                "**/apps/Admin/var/**",
                "**/apps/Api/var/**",
                "**/apps/Customer/var/**",
                "**/apps/Broker/var/**",
              },
            },
          },
        },
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      }
      ]]

      servers.phpactor = {
       cmd = { "phpactor", "language-server" },
       filetypes = { "php" },
       root_dir = vim.fs.dirname(vim.fs.find({ "composer.json", ".git" }, { upward = true })[1]),
       on_attach = handlers.on_attach,
       capabilities = handlers.capabilities,
       -- NO init_options = {} means it will use .phpactor.json or ask on first run
     }

      -- Lua Language Server (lua_ls)
      servers.lua_ls = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Omnisharp
      servers.omnisharp = {
        cmd = { "omnisharp" },
        capabilities = capabilities,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        root_dir = vim.fs.dirname(vim.fs.find({ "*.sln", "*.csproj" }, { upward = true })[1]),
        handlers = {
          ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
      }

      -- TypeScript Language Server (ts_ls)
      local vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      servers.ts_ls = {
        init_options = {
          preferences = {
            importModuleSpecifier = "non-relative",
            importModuleSpecifierEnding = "auto",
          },
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      }

      -- Volar (now vue_ls)
      servers.vue_ls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      }

      -- Setup all servers using Neovim 0.11+ API
      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
}
