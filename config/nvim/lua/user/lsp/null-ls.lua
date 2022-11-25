local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = true,
  sources = {
    diagnostics.yamllint.with({
      extra_args = { "-d { extends: default, rules: {line-length: {max: 120}}}" }
    }),
    diagnostics.psalm.with({
      extra_args = { "--config=psalm.xml" },
      condition = function(utils)
        return utils.root_has_file({ "psalm.xml" })
      end,
      timeout = 10000,
      command = "./vendor/bin/psalm"
    }),
    diagnostics.phpcs.with({
      extra_args = { "--standard=PSR12" }
    }),
    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.yamlfmt,
    formatting.phpcbf.with({ extra_args = { "--standard=PSR12" } }),
    formatting.phpcsfixer,
    -- diagnostics.flake8
  },
})

