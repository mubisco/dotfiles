local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

require('user.dap.virtualtext')
require('user.dap.ui')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME')..'/.local/share/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Gf Backend Xdebug',
    pathMappings = {
      ["/app"] = "${workspaceFolder}"
    },
    port = 9003
  }
}

-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = {'dap', '-l', '127.0.0.1:${port}'},
--   }
-- }

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
dap.adapters.delve = {
  type = "server",
  host = "127.0.0.1",
  port = 38697,
}
-- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F6>", "<Cmd>lua require'dap'.terminate()<CR>", opts)
keymap("n", "<F9>", "<Cmd>lua require'dap'.goto_()<CR>", opts)
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
keymap("n", "<F2>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
keymap("n", "<F3>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
keymap("n", "<F4>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
-- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
keymap("n", "<F10>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F11>", "<Cmd>lua require'dap'.clear_breakpoints()<CR>", opts)
keymap("n", "<F12>", "<Cmd>lua require'dap'.list_breakpoints()<CR>", opts)
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
