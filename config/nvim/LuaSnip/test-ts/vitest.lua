local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local i = ls.insert_node

return {
  s(
    { trig = "vtt", dscr = "Vitests test boilerplate" },
    fmta(
      [[
        test('<>', () => {
        })
      ]],
      { i(1, "test name"), i(0) }
    )
  )
}
