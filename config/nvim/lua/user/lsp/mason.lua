local handlers = require("user.lsp.handlers")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.intelephense = {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
  settings = {
    intelephense = {
      files = {
          maxSize = 5000000;
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
        }
      };
    };
  },
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}
--
-- Lua Language Server (lua_ls)
vim.lsp.config.lua_ls = {
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
vim.lsp.config.omnisharp = {
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
vim.lsp.config.ts_ls = {
  init_options = {
    preferences = {
      importModuleSpecifier = "non-relative",
      importModuleSpecifierEnding = "auto",
    },
  },
}
