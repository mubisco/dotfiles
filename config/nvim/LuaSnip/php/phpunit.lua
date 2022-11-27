local placeholderMap = { i(1, "expected"), i(2, "actual") }
local singlePlaceholderMap = { i(1, "actual") }

return {
  s(
    { trig = "ppt", dscr = "Generic boilerplate for simple Php Unit Test" },
    fmta(
      [[
        /** @test */
        public function <>(): void
        {
            <>
        }
      ]],
      { i(1, "test name"), i(0) }
    )
  ),
  s(
    { trig = "zct", dscr = "Generic boilerplate for simple Php Unit Test" },
    fmta(
      [[
        /**
         * @test
         * <>
         */
        public function <>(): void
        {
            <>
        }
      ]],
      { f(snakeize, {1}), i(1, "testName"), i(0) }
    )
  ),
  s({ trig = "ase"}, fmt("$this->assertEquals({}, {})", placeholderMap)),
  s({ trig = "asne"}, fmt("$this->assertNotEquals({}, {})", placeholderMap)),
  s({ trig = "ass"}, fmt("$this->assertSame({}, {})", placeholderMap)),
  s({ trig = "asns"}, fmt("$this->assertNotSame({}, {})", placeholderMap)),
  s({ trig = "asf"}, fmt("$this->assertFalse({})", singlePlaceholderMap)),
  s({ trig = "ast"}, fmt("$this->assertTrue({})", singlePlaceholderMap)),
  s({ trig = "asco"}, fmt("$this->assertCount({})", singlePlaceholderMap)),
  s({ trig = "asi"}, fmt("$this->assertInstanceOf({}, {})", placeholderMap)),
  s({ trig = "ashk"}, fmt("$this->assertArrayHasKey({}, {})", placeholderMap)),
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
