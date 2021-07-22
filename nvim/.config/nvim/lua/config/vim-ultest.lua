return function ()
  -- test
   vim.api.nvim_set_keymap('n', '<leader>utn', '<cmd>UltestNearest<cr>', { noremap = true })
   vim.api.nvim_set_keymap('n', '<leader>utf', '<cmd>Ultest<cr>', { noremap = true })
   -- misc
   vim.api.nvim_set_keymap('n', '<leader>uts', '<cmd>UltestSummary<cr>', { noremap = true })
   vim.api.nvim_set_keymap('n', '<leader>usf', '<cmd>UltestStop<cr>', { noremap = true })
   vim.api.nvim_set_keymap('n', '<leader>uso', '<cmd>UltestOutput<cr>', { noremap = true })
   -- debug
   vim.api.nvim_set_keymap('n', '<leader>udn', '<cmd>UltestDebugNearest<cr>', { noremap = true })
   vim.api.nvim_set_keymap('n', '<leader>uda', '<cmd>UltestAttach<cr>', { noremap = true })

   vim.g.ultest_use_pty = 1 -- coloured output
end
