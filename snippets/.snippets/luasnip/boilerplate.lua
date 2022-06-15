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

-- CODE HERE
--
-- table.insert(snippets, mySnip)

return snippets, autosnippets
