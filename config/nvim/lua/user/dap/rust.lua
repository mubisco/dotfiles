local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.adapters.lldb = {
  type = "executable",
  -- command = "/usr/bin/lldb-vscode", -- from codelldb Arch package
  command = "/sbin/codelldb", -- from codelldb Arch package
  name = "lldb"
}
dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  }
}
