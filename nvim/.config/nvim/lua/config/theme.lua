return function(colorscheme, style)
  -- NOTE: you must set the lualine theme in the config.lualine module.

  local function set_material()
    -- styles: darker; lighter; oceanic; palenight; deep ocean;
    vim.g.material_style = style or "deep ocean"
 
    vim.g.material_italic_comments = true
    vim.g.material_italic_keywords = true
    vim.g.material_italic_functions = false
    vim.g.material_italic_variables = false
    vim.g.material_contrast = true
    vim.g.material_borders = true
    vim.g.material_disable_background = false
    --vim.g.material_custom_colors = { black = "#000000", bg = "#0F111A" }

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
