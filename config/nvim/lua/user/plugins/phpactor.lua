return {
  "phpactor/phpactor",
  ft = "php",
  build = "composer install --no-dev -o",
  init = function()
    -- Use Mason's phpactor binary for execution, but let the plugin keep
    -- its own vendor/ so its dependency checks pass.
    vim.g.phpactorbinpath = vim.fn.stdpath("data") .. "/mason/bin/phpactor"
  end,
}
