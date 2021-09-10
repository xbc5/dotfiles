return function()
  require("lsp_signature").setup {
    bind = true, -- mandatory, else border config breaks
    extra_trigger_chars = {"(", "{", ","}
  }
end
