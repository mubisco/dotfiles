local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

require('user.dap.virtualtext')
require('user.dap.ui')
require('user.dap.keymaps')
require('user.dap.php')
require('user.dap.go')
require('user.dap.rust')

pcall(require, "user.dap.local")


--[[
In order to make specific configs please create in this folder a local.lua file
Then, just copy and paste this example config adapted to your needs.
local.lua file is ignored on purpose so each user can configure its own configs

local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

-- Add machine-specific DAP configs here. This file is git-ignored.
dap.configurations.php = dap.configurations.php or {}
table.insert(dap.configurations.php, {
  type = "php",
  request = "launch",
  name = "Fynkus Backend Xdebug",
  pathMappings = {
    ["/var/www"] = "${workspaceFolder}",
  },
  port = 9003,
})
]]
