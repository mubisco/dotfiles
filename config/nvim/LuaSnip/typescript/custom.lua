local ls = require("luasnip")
local s = ls.snippet
-- local fmta = require("luasnip.extras.fmt").fmta
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
-- local i = ls.insert_node

return {
  s({ trig = "esd", dscr = "Eslint disable next line"}, fmt("// eslint-disable-next-line", { })),
}
