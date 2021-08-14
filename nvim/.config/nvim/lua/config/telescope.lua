return function()
  local telescope = require("telescope")

  telescope.setup {
    -- these are mostly defaults
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      path_display = {},
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",        -- smart_case|ignore_case|respect_case
      },
      project = { -- project.nvim
        base_dirs = {
          "~/projects",
          "~/practice",
          "~/.dotfiles",
          -- {'~/dev/src3', max_depth = 4}, -- e.g.
        },
        hidden_files = true,
      }
    }
  }


  telescope.load_extension('fzf') -- MUST call AFTER setup


  -- project.nvim
  telescope.load_extension('project') -- project fuzzy finder
  vim.api.nvim_set_keymap(
    'n',
    '<leader>fpp',
    ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
    {noremap = true, silent = true}
  )


  local maps = {
    -- these two I use all the time, so make the map easy
    { "n", "find_files" },
    { "m", "buffers" },
    -- often used
    { "fgg", "live_grep" },
    { "fcb", "current_buffer_fuzzy_find" },
    { "fhh", "help_tags" },
    -- not so often used
    { "fkk", "keymaps" },
    { "fgs", "git_status" },
    { "fgc", "git_commits" },
    { "fts", "treesitter" },
    { "ffb", "file_browser" },
    { "fbs", "lsp_document_symbols" },
    { "fbr", "lsp_references" },
    { "fwd", "lsp_workspace_diagnostics" },
    { "fbd", "lsp_document_diagnostics" },
    { "fws", "lsp_workspace_symbols" },
  }

  for _, m in pairs(maps) do
    local keys = m[1]; local action = m[2]
    vim.api.nvim_set_keymap(
      'n', '<leader>'..keys, '<cmd>Telescope '..action..'<cr>', { noremap = true }
    )
  end

  vim.api.nvim_set_keymap('n', '<leader>fcc', '<cmd>lua require("lib.telescope").find_nvim_config()<cr>', { noremap = true })

end
