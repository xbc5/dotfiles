return function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      -- can be a string with: 'all', 'maintained', or a list
      -- available parsers that interest you: bash lua bibtex c cmake css dockerfile html jsonc (i.e. with comments)
      -- latex regex rust python svelte toml typescript vue yaml scss rst graphql go gomod cpp
      "bash", "lua", "css", "dockerfile", "html", "javascript", "jsonc", "regex",
      "rust", "python", "svelte", "toml", "typescript", "yaml", "scss", "rst",
    },
    ignore_install = { }, -- ignore these parsers

    -- MODULES: disabled by default;
    highlight = {
      enable = true,
      disable = { },  -- ignore these langs
      additional_vim_regex_highlighting = false, -- built-in hl; is slow + dupes; can be lang list 
    },
    indent = { -- experimental, unstable
      enable = false
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
end
