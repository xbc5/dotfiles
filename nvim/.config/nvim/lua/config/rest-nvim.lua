local M = {}

function M.preconditions()
  local exists = require'lib.sys'.cmd_exists

  -- NOTE: you must ALSO ensure (treesitter) json, html is installed
  -- :TSInstall json html
  assert(exists('jq'), 'rest-nvim: you must install jq.')
  assert(exists('curl'), 'rest-nvim: you must install curl.')
end

function M.config()
  local map = vim.api.nvim_set_keymap

  local opts = { noremap = true, silent = true }
  map('n', '<leader>rr', '<Cmd>lua require"rest-nvim".run()<CR>', opts) -- run highlighted line
  map('n', '<leader>rl', '<Cmd>lua require"rest-nvim".last()<CR>', opts) -- run the last command
end

return M
