return function()
	require("todo-comments").setup {
	  highlight = {
	    after = "bg", -- what to highlight
	    pattern = [[.*<(KEYWORDS)\s*]], -- : excluded
	  },
	  search = {
	    pattern = [[\b(KEYWORDS)]], -- ripgrep regex
	  },
	}

  local map = vim.api.nvim_set_keymap
  local opts = { silent = true, noremap = true }

  map('n', '<leader>tl', '<CMD>TodoTelescope<CR>', opts)
end
