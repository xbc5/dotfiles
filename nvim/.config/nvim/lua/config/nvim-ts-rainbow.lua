return function()
  require("nvim-treesitter.configs").setup {
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000, -- performance reasons probablu
      --colors = { "#d50000", "#d600ae", "#0043fc", "#00a2c2", "#00a923", "#d57300", "#a5bf01", } -- BUG: more than 7 breaks loading
      --termcolors = {} -- table of colour name strings
    }
  }
end
