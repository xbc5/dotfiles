return function()
  local npairs = require("nvim-autopairs").setup { check_ts = true }

  -- not a hard requirement, but I have require it in plugin setup.
  require('nvim-treesitter.configs').setup {
    autopairs = { enable = true }
  }
  
  -- you can add additional treesitter rules, it's quite powerful. See docs.
end
