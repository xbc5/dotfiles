local M = {}

function M.config()
  local map = vim.api.nvim_set_keymap
  local opts = { silent = true, noremap = true }

  -- yarn
  map('n', '<leader>cyb', '<Cmd>lua require("FTerm").scratch({ cmd = "yarn build || npm build" })<CR>', opts)
  map('n', '<leader>cyl', '<Cmd>lua require("FTerm").run("yarn check:lint || yarn lint || npm lint")<CR>', opts)
  map('n', '<leader>cyct', '<Cmd>lua require("FTerm").run("yarn check:types")<CR>', opts)
  map('n', '<leader>cyt', '<Cmd>lua require("FTerm").run("yarn test || npm test")<CR>', opts)

  -- prog
  map('n', '<leader>gg', '<Cmd>lua require("FTerm").scratch({ cmd = "lazygit" })<CR>', opts)

  -- term
  map('n', '<A-Space>', '<Cmd>lua require("FTerm").toggle()<CR>', opts)
  map('t', '<A-Space>', '<Cmd>lua require("FTerm").toggle()<CR>', opts)

end

return M
