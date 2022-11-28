local function currentDate()
  return os.date("%Y-%m-%d")
end

return {
  s(
    { trig = "rtException", dscr = "Inserts generic RuntimeException to detect unwanted method execution" },
    { t("throw new \\RuntimeException(sprintf('Implement %s', __METHOD__));") }
  ),
  s(
    { trig = "todo", dscr = "Creates generic TODO sign with date and user" },
    { t("// TODO "), f(currentDate, {}), t(": "), i(0) }
  ),
}
