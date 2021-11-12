local M = {}

function M.config()
  require'lspsaga'.setup {
    debug = true,
  }

  local map = vim.api.nvim_set_keymap
  local opts = { silent = true, noremap = true }

  -- refactor
  map("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
  map("n", "<leader>lca", "<cmd>Lspsaga code_action<cr>", opts)

  -- navigation
  map("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<cr>", opts)

  -- docs
  map("n", "<leader>ld",  "<cmd>Lspsaga hover_doc<cr>", opts)
  map("n", "<leader>ls",  "<cmd>Lspsaga signature_help<cr>", opts)

  -- diagnostics
  map("n", "<leader>lld", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  map("n", "<leader>lcd", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
  map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
end

return M
