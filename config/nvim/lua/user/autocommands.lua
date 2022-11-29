vim.cmd [[
  augroup _php_settings
    autocmd!
    autocmd FileType php :setlocal sw=4 ts=4 sts=4
  augroup end
]]

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

