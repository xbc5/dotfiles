local M = {}

function M.config()
  local dapui = require("dapui")

  dapui.setup()

  local map = vim.api.nvim_set_keymap
  local opts = { silent = true, noremap = true }

  map('n', '<leader>es',  '<Cmd>lua require("dapui").float_element("scopes", { enter = true })<CR>', opts)
  map('n', '<leader>ebp', '<Cmd>lua require("dapui").float_element("breakpoints", { enter = true })<CR>', opts)
  map('n', '<leader>eS',  '<Cmd>lua require("dapui").float_element("stacks", { enter = true })<CR>', opts)
  map('n', '<leader>ew',  '<Cmd>lua require("dapui").float_element("watches", { enter = true })<CR>', opts)
  map('v', '<leader>ee',  '<Cmd>lua require("dapui").eval(nil, { enter = true })<CR>', opts)
  map('n', '<leader>ee',  '<Cmd>lua require("dapui").eval(nil, { enter = true })<CR>', opts)

end

return M
