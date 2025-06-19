return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    -- local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      debug = true,
      sources = {
        diagnostics.twigcs,
        diagnostics.phpstan.with({
          command = "./vendor/bin/phpstan"
        }),
        diagnostics.yamllint.with({
          extra_args = { "-d { extends: default, rules: {line-length: {max: 120}}}" }
        }),
        -- diagnostics.psalm.with({
          -- method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          -- extra_args = { "--config=.psalm-nvim.xml" },
          -- condition = function(utils)
            -- return utils.root_has_file({ ".psalm-nvim.xml" })
          -- end,
          -- timeout = 20000,
          -- command = "./vendor/bin/psalm"
        -- }),
        diagnostics.phpcs.with({
          command = "./vendor/bin/phpcs",
          extra_args = { "--standard=PSR12" }
        }),
        -- diagnostics.phpmd.with({
        --   command = "./vendor/bin/phpmd",
        --   extra_args = { "cleancode,codesize,controversial,design,naming,unusedcode" }
        -- }),
        -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.prettier,
        -- formatting.prettierd,
        -- code_actions.eslint,
        formatting.gofmt,
        -- formatting.gofumpt,
        formatting.goimports,
        diagnostics.staticcheck,
        -- diagnostics.revive,
        diagnostics.zsh,
        diagnostics.golangci_lint,
        diagnostics.npm_groovy_lint,
        diagnostics.semgrep.with({ filetypes = {"go"}, extra_args = { "--config=auto" }}),
        formatting.csharpier,
        -- formatting.json_tool,
        -- diagnostics.eslint,
        -- formatting.eslint,
        -- formatting.xmllint,
        diagnostics.stylelint,
        formatting.phpcbf,
        formatting.stylelint,
        formatting.tidy,
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        formatting.yamlfmt,
        formatting.phpcbf.with({ extra_args = { "--standard=PSR12" } }),
        -- formatting.phpcsfixer,
        formatting.shfmt
        -- diagnostics.flake8
      },
    })
  end
}
