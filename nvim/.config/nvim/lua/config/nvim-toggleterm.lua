local M = {}


function M.config()
  -- don't destroy terminal when its hidden; also allow npm watch etc.
  vim.api.nvim_command("set hidden")

  require("toggleterm").setup{
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "1", -- 1:dark;3:light;
    start_in_insert = true,
    insert_mappings = true, -- do mappings apply to insert mode
    persist_size = true,
    direction = "vertical",
    close_on_exit = true, -- close terminal on process exit
    float_opts = { -- only for float terms
      border = "single",
      width = 20,
      height = 100,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
end


return M
