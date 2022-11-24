local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.psalm.with({
      extra_args = { "--config=psalm.xml" },
      condition = function(utils)
        return utils.root_has_file({ "psalm.xml" })
      end,
      command = "./vendor/bin/psalm"
    }),
    diagnostics.phpcs,
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.phpcbf,
    formatting.phpcsfixer,
    -- diagnostics.flake8
  },
})

