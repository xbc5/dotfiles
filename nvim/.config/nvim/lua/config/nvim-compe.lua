return function()
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    source = { -- required
      path = true;
      buffer = true;
      calc = false;
      nvim_lsp = true;
      nvim_lua = true;
      vsnip = true;
      ultisnips = false;
      luasnip = false;
    };
  }

  vim.o.completeopt = "menuone,noinsert,noselect"
  -- don't give ins-completion-menu message
  vim.o.shortmess = vim.o.shortmess.."c"

  local keymap = vim.api.nvim_set_keymap
  local expr = { expr = true, silent = true }

  keymap('i', '<C-Space>', 'compe#complete()', expr)
  keymap('i', '<C-e>', 'compe#close("<C-e>")', expr)
  keymap('i', '<C-f', 'compe#scroll({ "delta": +4 })', expr)
  keymap('i', '<C-d', 'compe#scroll({ "delta": -4 })', expr)
end
