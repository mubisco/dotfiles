local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup {
  adapters = {
    require("neotest-phpunit"),
    require("neotest-go"),
    require("neotest-vitest"),
    require("neotest-jest")
  }
}
