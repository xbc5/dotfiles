local ls = require('luasnip')
local snip = ls.s
local insert  = ls.i
local text = ls.t

local dyn = ls.dynamic_node
local choice = ls.choice_node
local func = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local function expectThrows()
  local str = [[
    expect(() => {fn}){negation}.toThrow();
  ]]
  return fmt(str, {
    fn = insert(1),
    negation = choice(2, { text(""), text(".not")})
  })
end
table.insert(snippets, snip('tt', expectThrows()))

local function expected(matcher)
  local str = [[
    const expected = {expected};
    const result = {result};
    expect(result){negation}.{matcher};
  ]]
  return fmt(str, {
    result = insert(1),
    expected = insert(2),
    negation = choice(3, { text(""), text(".not")}),
    matcher = matcher,
  })
end

-- like expected, but without the expected var.
local function expectless(matcher)
  local str = [[
    const result = {result};
    expect(result){negation}.{matcher};
  ]]
  return fmt(str, {
    result = insert(1),
    negation = choice(2, { text(""), text(".not")}),
    matcher = text(matcher),
  })
end

local function insertMatchers(...)
  for _, cfg in ipairs({...}) do
    local fn
    local trig = cfg[1]
    local matcher = cfg[2]

    -- dispatch a different snip if matcher doesn't take an expected value.
    -- This other snip won't include an expected variable
    if string.match(matcher, "%(expected%)")
      then fn = expected
      else fn = expectless
    end

    table.insert(
      snippets,
      snip({ trig = trig, name = matcher }, fn(matcher))
    )
  end
end

insertMatchers(
  {'tmo', "toMatchObject(expected)" },
  {'tb', "toBe(expected)" },
  {'tse', "toStrictEqual(expected)" },
  {'tms', "toMatchSnapshot()" },
  {'tbn', "toBeNull()" },
  {'tbu', "toBeUndefined()" },
  {'tbt', "toBeTruthy()" },
  {'tm', "toMatch(expected)" },
  {'te', "toEqual(expected)" },
  {'tc', "toContain(expected)" }
)

local itStr = [[
it("should {}", async () => {{
  {}
}})
]]
local it = snip('it',
  fmt(itStr, {
    insert(1),
    insert(2),
  })
)
table.insert(snippets, it)


local varStr = "{} {} = {};"
local var = snip('var',
  fmt(varStr, {
    choice(1, {
      text("const"),
      text("let"),
      text("var"),
    }),
    insert(2),
    insert(3),
  })
)
table.insert(snippets, var)

local notImplmentedStr = 'throw Error("Not implemented!");'

-- curly braces, with insertion between them
local function fnBlock()
  return fmt("{{\n  {}\n}}", { insert(1, notImplmentedStr) })
end

-- optional async, with arg and content.
local function callbackArrow()
  local str = "{}({}) => {}"
  return fmt(str, {
    choice(2, { text(""), text("async ") }),
    insert(1),
    choice(3, { insert(1), fnBlock()}),
  })
end

local function callbackOG()
  local str = "{}function ({}) {}"
  return fmt(str, {
    choice(2, { text(""), text("async ") }),
    insert(1),
    sn(3, fnBlock())
  })
end
local function callbacks() return { callbackArrow(), callbackOG() } end
table.insert(snippets, snip('cb', choice(1, callbacks())))

local fnArrow = fmt([[
const {} = ({}) => {}
]], {
  insert(1),
  insert(2),
  choice(3, { fmt("{};", insert(1)), fnBlock() }),
})

local fnOG = fmt([[
{}function {}({}) {{
  {}
}}
]], {
  choice(3, { text(""), text("async ") }),
  insert(1),
  insert(2),
  insert(4, notImplmentedStr),
})

local fn = snip('fn', choice(1, { fnOG, fnArrow }))

table.insert(snippets, fn)

local function forEach(...)
  local cb = {...}
  if #{...} == 0 then cb = callbacks() end

  local str = "{}.forEach({})"
  return fmt(str, {
    choice(1, {
      insert(1),
      fmt("[\n  {}\n]", { insert(1) })
    }),
    choice(2, cb)
  })
end
table.insert(snippets, snip('fe', forEach()))

local function desc()
  local str = [[
    describe("{description}", () => {{
      {content}
    }})
  ]]
  return fmt(str, {
    description = insert(1),
    content = insert(2),
  })
end

local function descEach()
  local main = [[
    {subject}.forEach(({args}) => {{
      describe("{description}", () => {{
        {content}
      }})
    }})
  ]]

  return fmt(main, {
    description = insert(1),
    subject = choice(2, {
      fmt("[\n  {}\n]", { insert(1) }),
      insert(1),
    }),
    args = insert(3),
    content = insert(4),
  })
end

table.insert(snippets, snip('desc', choice(1, { desc(), descEach() })))

local function method()
  -- NOTE: formatting deliberately offset by two spaces -- it works; leave it.
  local str = [[
    {async}{name}({args}) {{
        {code}
      }}
  ]]
  return fmt(str, { 
    name = insert(1),
    async = choice(2, { text(""), text("async ") }),
    args = insert(3),
    code = insert(4)
  })
end

local function class()
  local _class = [[
    class {name} {extends}{{
      {constructor}
      {method}
    }}
  ]]

  -- NOTE: formatting deliberately offset by two spaces -- it works; leave it.
  local _constructor = [[
    constructor({args}) {{
        {code}
      }}

  ]]

  return fmt(_class, {
    name = insert(1),
    extends = choice(2, {
      text(""),
      fmt("extends {} ", insert(1))
    }),
    constructor = choice(3, {
      text(""),
      fmt(_constructor, {
        args = insert(1),
        code = choice(2, {
          insert(nil),
          fmt("super();\n    {}", {
            insert(1)
          })
        }),
      }),
    }),
    method = choice(4, { text(""), method() })
  })
end

table.insert(snippets, snip({ trig = "class", name = "Class" }, class()))
table.insert(snippets, snip({ trig = "meth", name = "Method" }, method()))

return snippets, autosnippets
