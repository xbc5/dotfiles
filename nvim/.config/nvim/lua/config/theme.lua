return function(colorscheme, style)
  -- NOTE: you must set the lualine theme in the config.lualine module.

  local function set_material()
    -- styles: darker; lighter; oceanic; palenight; deep ocean;
    vim.g.material_style = style or "deep ocean"

    require('material').setup({
      contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
      borders = true, -- Enable borders between verticaly split windows

      italics = {
        comments = true, -- Enable italic comments
        keywords = true, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false -- Enable italic variables
      },

      contrast_windows = { -- Specify which windows get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf" -- Darker qf list background
      },

      text_contrast = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
      },

      disable = {
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
      }
    })

    vim.cmd("colorscheme material")
  end


  local function set_neon()
    -- styles: default; doom; dark; light;
    vim.g.neon_style = style or "default"

    vim.g.neon_italic_keyword = true      -- for, do, while, loops etc
    vim.g.neon_italic_function = true     -- funcs, methods
    vim.g.neon_italic_boolean = false
    vim.g.neon_italic_variable = false
    vim.g.neon_italic_comment = false
    vim.g.neon_bold = false               -- errors, warnings, lsp etc.

    vim.cmd("colorscheme neon")
  end


  local switch = {
    material = set_material,
    neon = set_neon,
  }


  local fn = assert(switch[colorscheme or "neon"], "Invalid theme name: "..colorscheme)
  fn()
end
