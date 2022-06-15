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


local hello = snip("hello", { text("Hello snippets!") })
table.insert(snippets, hello)

local helloSnip = "Hello {} "
local hello2 = snip("hello2",
  fmt(helloSnip, {
    choice(1, {
      text("World!"),
      text("Snippets!"),
    })
  })
)
table.insert(snippets, hello2)

local funcSnip = [[
local function {}({})
  {}
end]]
local func = snip("fn", fmt(funcSnip, {
  insert(1, ""),
  insert(2, ""),
  insert(0, ""),
}))
table.insert(snippets, func)

return snippets, autosnippets
