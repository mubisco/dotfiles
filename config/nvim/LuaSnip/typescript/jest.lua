local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node

return {
  s(
    { trig = "jest", dscr = "Generic boilerplate for Jest test" },
    {
      t({"import { describe, expect, test } from '@jest/globals';", "", "describe('"}),
      i(1, "describe text"),
      t({"', () => {", "\ttest('"}),
      i(2, "test text"),
      t{"', () => {", "\t});","});"}
    }
  ),
}
