local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local function snakeize(args, parent)
  return string.lower(string.gsub(args[1][1], "%u", "_%1"))
end
local namefile = function()
  return f(function(_args, snip)
    local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
    return name[1] or ""
  end)
end

return {
  s(
    { trig = "ppt", dscr = "Generic boilerplate for simple Php Unit Test" },
    fmta(
      [[
        public function test<>(): void
        {
            <>
        }
      ]],
      { i(1, "test name"), i(0) }
    )
  ),
  s(
    { trig = "__te", dscr = "Generic boilerplate for simple Php Unit Test" },
    fmta(
      [[
        /**
         * @test
         * <>
         * @group <>
         */
        public function <>(): void
        {
            <>
        }
      ]],
      { f(snakeize, {1}), namefile(), i(1, "testName"), i(0) }
    )
  ),
  s({ trig = "asco"}, fmt("$this->assertCount({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "asi"}, fmt("$this->assertInstanceOf({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "ashk"}, fmt("$this->assertArrayHasKey({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "ase"}, fmt("$this->assertEquals({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "asne"}, fmt("$this->assertNotEquals({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "ass"}, fmt("$this->assertSame({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "asns"}, fmt("$this->assertNotSame({}, {})", { i(1, "expected"), i(2, "actual") })),
  s({ trig = "asf"}, fmt("$this->assertFalse({})", { i(1, "actual")})),
  s({ trig = "ast"}, fmt("$this->assertTrue({})", { i(1, "actual") })),
  s({ trig = "eex"}, fmt("$this->expectException({})", { i(1, "actual") })),
}
-- snippet asfex "$this->assertFileExists('path/to/file')"
--   $this->assertFileExists(${1:'path/to/file'});
--   snippet asfnex "$this->assertFileNotExists('path/to/file')"
--     $this->assertFileNotExists(${1:'path/to/file'});
--   snippet ascon "$this->assertContains($needle, $haystack)"
--     $this->assertContains(${1:$needle}, ${2:$haystack});
--   snippet asncon "$this->assertNotContains($needle, $haystack)"
--     $this->assertNotContains(${1:$needle}, ${2:$haystack});
--   snippet ascono "$this->assertContainsOnly($needle, $haystack)"
--     $this->assertContainsOnly(${1:$needle}, ${2:$haystack});
--   snippet asconoi "$this->assertContainsOnlyInstancesOf(Example::class, $haystack)"
--     $this->assertContainsOnlyInstancesOf(${1:Example}::class, ${2:$haystack});
--   snippet asnhk "$this->assertArrayNotHasKey($key, $array)"
--     this->assertArrayNotHasKey(${1:$key}, ${2:$array});
--   snippet ascha "$this->assertClassHasAttribute($name, Example::class)"
--     $this->assertClassHasAttribute(${1:$attributeName}, ${2:Example}::class);
--   snippet asit "$this->assertInternalType('string', $actual)"
--     $this->assertInternalType(${1:'string'}, ${2:actual});
--   snippet asnco "$this->assertNotCount($count, $haystack)"
--     $this->assertNotCount(${1:$count}, ${2:$haystack});
--   snippet assub "$this->assertArraySubset($subset, $array)"
--     $this->assertArraySubset(${1:$subset}, ${2:$array});
--   snippet asnu "$this->assertNull($a)"
--
