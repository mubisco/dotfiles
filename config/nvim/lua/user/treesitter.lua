local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "rust",
    "scss",
    "sql",
    "tsx",
    "twig",
    "typescript",
    "vim",
    "vue",
    "yaml"
  }, -- one of "all" or a list of languages
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.twig = {
  install_info = {
    url = "eirabben/tree-sitter-twig",
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main",
  },
  filetype = "twig",
}
