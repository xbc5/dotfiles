local M = {}

function M.config()
  local map = vim.api.nvim_set_keymap
  local g = vim.api.nvim_set_var

  g('rnvimr_enable_ex', 1) -- replace buitin FM (Netrw)
  g('rnvimr_enable_bw', 1) -- delete buffer when file is deleted

  -- border
  g('rnvimr_draw_border', 1) -- BUG: doesn't work
  g('rnvimr_ranger_cmd', { 'ranger', '--cmd=set draw_borders both' }) -- inner borders

  -- keys
  local opts = { silent = true, noremap = true }
  map('n', '<A-o>', '<Cmd>RnvimrToggle<CR>', opts)
  map('t', '<A-o>', '<Cmd>RnvimrToggle<CR>', opts)
end

return M
