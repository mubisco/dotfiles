local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

lspconfig.intelephense.setup({
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
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.omnisharp.setup({
  cmd = { "omnisharp" },
  capabilities = capabilities,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj"),
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
})
