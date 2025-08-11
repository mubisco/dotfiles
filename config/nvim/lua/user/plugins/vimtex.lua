return {
  "lervag/vimtex",
  ft = { "tex" },
  init = function()
    -- Use latexmk with xelatex
    vim.g.vimtex_compiler_latexmk = {
      executable = 'latexmk',
      options = {
        '-xelatex',
        '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }

    -- PDF viewer
    vim.g.vimtex_view_method = 'general'

    -- Quickfix error handling
    vim.g.vimtex_quickfix_mode = 1

    -- Auto compile on open
    vim.g.vimtex_compiler_start = 1

    -- Do not use conceal (optional)
    vim.g.vimtex_syntax_conceal = { accents = 0, ligatures = 0, math_delimiters = 0 }
  end,
}

