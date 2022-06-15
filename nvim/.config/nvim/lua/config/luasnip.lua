local M = {}

function M.config()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')

  require('luasnip.loaders.from_lua').load({ paths = '~/.snippets/luasnip/'})

  ls.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI', -- so function and dynamic nodes will update
    enable_autonsippets = true,
    ext_opts = {
      -- see :h luasnip-ext_marks
      [types.choiceNode] = {
        active = {
          -- when the node is focused
          virt_text = {{ "<-- Choice", "DiagnosticVirtualTextInfo" }},
        },
      }
    }
  })

  local function next_choice()
    if ls.choice_active() then ls.change_choice(1) end
  end
  local function prev_choice()
    if ls.choice_active() then ls.change_choice(-1) end
  end

  local opts = { silent = true }
  vim.keymap.set("i", "<M-p>", prev_choice, opts)
  vim.keymap.set("s", "<M-p>", prev_choice, opts)
  vim.keymap.set("i", "<M-n>", next_choice, opts) -- BUG: throws when no active choice
  vim.keymap.set("s", "<M-n>", next_choice, opts)

end

return M
