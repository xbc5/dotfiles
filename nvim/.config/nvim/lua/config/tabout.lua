return function ()
  require('tabout').setup {
    tab_key = "", -- blank to satisfy above bindings
    backwards_tab_key = "", -- keep blank
    -- act_as_shift_tab = true, -- [false] allow reverse shift if supported by terminal
  }

  local function init_tab_bindings()
    local function replace_keycodes(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local function pumvisible() return vim.fn.pumvisible() ~= 0 end
    local function vsnipvisible() return vim.fn["vsnip#available"](1) ~= 0 end
    local function vsnipjumpable() return vim.fn["vsnip#jumpable"](-1) ~= 0 end

    function _G.tab_binding()
      if pumvisible() then
        return replace_keycodes("<C-n>")
      elseif vsnipvisible() then
        return replace_keycodes("<Plug>(vsnip-expand-or-jump)")
      else
        return replace_keycodes("<Plug>(Tabout)")
      end
    end

    function _G.s_tab_binding()
      if pumvisible() then
        return replace_keycodes("<C-p>")
      elseif vsnipjumpable() then
        return replace_keycodes("<Plug>(vsnip-jump-prev)")
      else
        return replace_keycodes("<Plug>(TaboutBack)")
      end
    end

    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_binding()", {expr = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_binding()", {expr = true})
  end

  init_tab_bindings()
end


