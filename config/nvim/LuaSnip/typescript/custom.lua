local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function currentFileName()
  local bufferName = vim.api.nvim_buf_get_name(0)
  local filename = bufferName:match("^.+/(.+)$")
  local name_without_extension = filename:match("(.+)%..+$")
  return name_without_extension
end

return {
  s({ trig = "esd", dscr = "Eslint disable next line"}, fmt("// eslint-disable-next-line", { })),
  s({ trig = "cll", dscr = "Console log"}, {
    t"console.log(",
    i(1, "something to log"),
    t")"
  }),
  s({ trig = "tif", dscr = "Create TS Interface"}, {
    t"export interface ",
    f(currentFileName, {}),
    t" {}",

  }),
  s({ trig = "tcl", dscr = "Create TS Class"}, {
    t"export class ",
    f(currentFileName, {}),
    t" {}",
  }),
  s({ trig = "tty", dscr = "Create TS Type"}, {
    t"export type ",
    f(currentFileName, {}),
    t" = {}",
  }),
  s({ trig = "ten", dscr = "Create TS Enum"}, {
    t"export enum ",
    f(currentFileName, {}),
    t" {}",
  }),
}
