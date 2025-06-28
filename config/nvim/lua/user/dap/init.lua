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
