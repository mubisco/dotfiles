local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

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
