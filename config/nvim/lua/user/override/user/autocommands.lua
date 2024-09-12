vim.cmd([[
  augroup _yaml_settings
    autocmd!
    autocmd FileType yaml :setlocal ts=2 sts=2 sw=2 expandtab
  augroup end
]])
vim.cmd([[
  augroup _behat_settings
    autocmd!
    autocmd FileType feature :setlocal sw=4 ts=4 sts=4
  augroup end
]])
vim.cmd([[
  augroup _custom_filetypes
    autocmd!
    autocmd BufNewFile,BufRead .env.* setf sh
  augroup end
]])
local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'Visual', timeout = 600})
  end
})
