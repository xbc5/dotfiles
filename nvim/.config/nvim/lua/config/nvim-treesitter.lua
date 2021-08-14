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
    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- block, call, class, comment, conditional, frame, function
          --  loop parameter and scopename -- all in the form: @foo.inner|outer.
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",

          -- Or you can define your own textobjects like this
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
          },
        },
      },
      move = {
        -- navigate; jump to start/end of functions/classes
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        -- swap function parameters
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  }
end
