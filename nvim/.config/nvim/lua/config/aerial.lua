local M = {}

function M.on_attach(client)
  require'aerial'.on_attach(client)

  -- Aerial does not set any mappings by default.
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})

  vim.g.aerial = {
    open_automatic = false,
  }
end

return M
