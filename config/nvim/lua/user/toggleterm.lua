local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

local codex = Terminal:new({
  cmd = "codex",
  direction = "vertical",
  size = function()
    return math.floor(vim.o.columns * 0.4) -- ~40% of the screen width
  end,
  start_in_insert = false,
  close_on_exit = false,
  hidden = true,
  dir = function()
    local ok, git_root = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
    if ok and git_root[1] ~= "" then
      return git_root[1]
    end
    return vim.uv.cwd()
  end,
  on_open = function(term)
    vim.cmd("stopinsert") -- leave normal mode
    vim.api.nvim_buf_set_option(term.bufnr, "buflisted", true)
    vim.api.nvim_buf_set_option(term.bufnr, "filetype", "codex")
    vim.b[term.bufnr].term_title = "Codex" -- statusline hook
    vim.b[term.bufnr].is_codex_terminal = true
  end,
})

function _CODEX_TOGGLE()
  codex:toggle()
end

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
  node:toggle()
end

local bashtop = Terminal:new({ cmd = "bashtop", hidden = true })

function _BASHTOP_TOGGLE()
  bashtop:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
  htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
  python:toggle()
end
