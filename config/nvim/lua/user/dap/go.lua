local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go
dap.adapters.delve = {
  type = "server",
  host = "127.0.0.1",
  port = 38697,
}

-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = {'dap', '-l', '127.0.0.1:${port}'},
--   }
-- }

-- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"

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
