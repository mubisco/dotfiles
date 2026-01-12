return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ts = require("nvim-treesitter")

    local parsers = {
      "bash",
      "bibtex",
      "c",
      "c_sharp",
      "css",
      "dockerfile",
      "diff",
      "go",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "latex",
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
      "yaml",
    }

    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = args.match

        -- Enable highlighting
        pcall(vim.treesitter.start)

        -- Enable indentation (except for python)
        if lang ~= "python" then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
