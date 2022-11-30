local function configVdebug(ideKey, localPath, remotePath)
  vim.cmd('VdebugOpt ide_key ' .. ideKey)
  vim.cmd('let g:vdebug_options.path_maps = {"' .. remotePath .. '": "' .. localPath .. '"}')
end
--[[
local function configVdebugRm()
  local remotePath = '/app'
  local localPath = '/home/xbellon/Projects/gf-monorepo/backend'
  local ideKey = 'GETLIFE_XDEBUG'
  configVdebug(ideKey, localPath, remotePath)
end ]]

local function configVdebugGetlife()
  local remotePath = '/app'
  local localPath = '/home/xbellon/Projects/gf-monorepo/backend'
  local ideKey = 'GETLIFE_XDEBUG'
  configVdebug(ideKey, localPath, remotePath)
end

vim.g.vdebug_options = {
  break_on_open = 0,
  port = 9003,
  debug_file = '~/vdebug.log',
  debug_file_level = 2,
  ide_key = ''
}

vim.api.nvim_create_user_command(
  'DebugGf',
  configVdebugGetlife,
  {}
)
