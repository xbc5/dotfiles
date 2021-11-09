local M = {}

function M.config()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({
        select = true, -- when <CR>, auto select first if none selected
        behavior = cmp.ConfirmBehavior.Replace,
      }),
    },

    sources = cmp.config.sources(
      -- order of importance, outer table is to facilitate this
      {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      },
      {
        { name = 'buffer' },
      }
    )

  })

  vim.o.completeopt = "menu,menuone,noselect,noinsert"
end

function M.lsp_config()
  -- require'lspconfig'['server'].setup({ capabilities = nvim_cmp.lsp_config() })
  -- in other words: use this value to set the 'capabilities' key in lspconfig.
  return require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return M
