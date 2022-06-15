local M = {}

function M.config()
  local cmp = require('cmp')
  local ls = require('luasnip')
  local nvim = require('lib.nvim')

  local function exitInsert() vim.cmd('stopinsert') end

  cmp.setup({
    snippet = {
      expand = function(args)
        if not ls then return end
        ls.lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),

      ['<M-Space>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          })
        else
          cmp.complete()
        end
      end, { 'i', 'c', 's' }),

      ['<M-h>'] = cmp.mapping(function(fallback)
        if ls.jumpable(-1) then
          ls.jump(-1)
        elseif nvim.is_mode('i') then
          exitInsert()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<M-l>'] = cmp.mapping(function(fallback)
        if ls.jumpable(1) then
          ls.jump(1)
        elseif nvim.is_mode('i') then
          exitInsert()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<M-j>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif nvim.is_mode('i') then
          exitInsert()
        else
          fallback()
        end
      end, { 'i', 's' }), -- map it for input and select modes

      ['<M-k>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif nvim.is_mode('i') then
          exitInsert()
        else
          fallback()
        end
      end, { 'i', 's' }),

    },

    formatting = {
      format = require('lspkind').cmp_format({
        mode = 'symbol_text',
      })
    },

    sources = cmp.config.sources(
      -- order of importance, outer table is to facilitate this
      {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
      },
      {
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
      }
    ),

    completion = {
      completeopt = "menuone,preview,noselect,noinsert"
    }
  })
end

function M.lsp_config()
  -- require'lspconfig'['server'].setup({ capabilities = nvim_cmp.lsp_config() })
  -- in other words: use this value to set the 'capabilities' key in lspconfig.
  return require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return M
