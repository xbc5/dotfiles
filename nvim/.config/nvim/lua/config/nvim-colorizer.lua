return function()
  require("colorizer").setup {
    -- Add options to a filetype key -- e.g. 'typescript' = {}
    --[[ DEFAULTS
    RGB      = true;         -- #RGB hex codes
    RRGGBB   = true;         -- #RRGGBB hex codes
    names    = true;         -- "Name" codes like Blue
    RRGGBBAA = false;        -- #RRGGBBAA hex codes
    rgb_fn   = false;        -- CSS rgb() and rgba() functions
    hsl_fn   = false;        -- CSS hsl() and hsla() functions
    css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn 
    mode     = 'background'; -- Set the display mode: foreground/background ]]
    '*', -- enable for all extensions, but does not take a table (must be string only, and first defined too.
  }
end
