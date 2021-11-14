-- NOTES
-- * running PackerSync also runs PackerCompile, but PackerUpdate does not;
-- * PackerSync will ask to remove packages that are not specified in here;
-- * you can test that a plugin has loaded: p = packer_plugins["foo"]; p and p.loaded;
-- * the log file is @ `echo stdpath(cache)`, typically ~/.cache/nvim;

local sys = require("lib.sys")
local npm = require("lib.npm")

-- don't run any installations as root or in Qubes templates
-- NOTE: make sure that this is the root of all of your plugin configuration, because
--  it will not run under Qubes templates, or as root. It must not break anything if it
--  doesn't run.
if not sys.is_user() or sys.is_templatevm() then return end

-- auto compile after updating this file;
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
local const = require("lib.const")

-- install it if it doesn't already exist.
local function auto_install_packer()
  if not sys.is_user() or sys.is_templatevm() then return end
  
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
  end
end

auto_install_packer()

return require('packer').startup({function(use)
    -- startup(spec), 'spec' can be: fn, table+conf_table; fn+conf_table.
    -- You can alternatively use init() to set fine grained options.
    -- See docs if you want to set packer configuration options.
 
    use 'wbthomason/packer.nvim' -- manage packer updates
    -- use 'nvim-lua/completion-nvim'
    use 'b3nj5m1n/kommentary'
    -- use 'takac/vim-hardtime'
    --
    use {
      'numtostr/FTerm.nvim',
      config = require'config.fterm-nvim'.config
    }

    use {
      'kevinhwang91/rnvimr',
      config = require'config.rnvimr'.config,
    }

    ----------------------------------------------------------------------------
    --                               EDITOR                                   --
    ----------------------------------------------------------------------------
    use "tpope/vim-surround"
    use {
      "windwp/nvim-autopairs",
      disable = true,
      requires = { "nvim-treesitter/nvim-treesitter" },
      config = require("config.nvim-autopairs"),
    }


    ----------------------------------------------------------------------------
    --                                GIT                                     --
    ----------------------------------------------------------------------------
    use {
      'pwntester/octo.nvim',
      disable = true,
      config = require("config.octo"),
      requires = {'nvim-telescope/telescope.nvim','kyazdani42/nvim-web-devicons'},
    }


    ----------------------------------------------------------------------------
    --                                IDE                                     --
    ----------------------------------------------------------------------------
    use {
      disable = true, -- causes <Tab> => 0 bug
      'abecodes/tabout.nvim',
      config = require("config.tabout"),
      requires = {'nvim-treesitter'},
    }

    use 'stevearc/aerial.nvim'

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = require("config.indent-blanklines-nvim"),
    }

    use {
      'kabouzeid/nvim-lspinstall',
      requires = { "neovim/nvim-lspconfig" },
      config =  function()
        require("config.nvim-lspinstall").config()
      end
    }

    use {
      "mfussenegger/nvim-ts-hint-textobject",
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "nvim-treesitter",
      -- configured in treesitter config module.
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "nvim-treesitter",
      -- configured in treesitter config module.
    }

    use {
      -- run :checkhealth nvim_treesitter to debug
      -- there's a playground plugin (visual tree-walker) if you wish to do some hacking
      'nvim-treesitter/nvim-treesitter',
      run = {':TSUpdate'}, -- instead use ensure_installed config option for installing parsers.
      config = require("config.nvim-treesitter"),
    }

    use {
      "tami5/lspsaga.nvim",
      config = require("config.lspsaga").config,
    }

    use {
      'hrsh7th/nvim-cmp',
      config = require("config.nvim-cmp").config,
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'ray-x/cmp-treesitter' },
        {
          'hrsh7th/cmp-vsnip', -- vsnip integration
          after = 'nvim-cmp',
          requires = {
            'hrsh7th/vim-vsnip', -- no point in cmp-vsnip unless you have this
            {
              'rafamadriz/friendly-snippets', -- for good measure
              after = 'cmp-vsnip'
            }
          }
        }
      }
    }


    use {
      "ray-x/lsp_signature.nvim",
      config = require("config.lsp_signature"),
    }

    use {
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim"},
      config = function()
        require("config.nvim-dap")() -- some debuggers are not covered by dap-install
        require("config.dap-install")()
        require("config.nvim-dap-ui")()
      end,
    }

    -- PlantUML
    use {
      "weirongxu/plantuml-previewer.vim",
      requires = { "aklt/plantuml-syntax", "tyru/open-browser.vim" }
    }
    ----------------------------------------------------------------------------
    --                            LOOK & FEEL                                 --
    ----------------------------------------------------------------------------
    use {
      "p00f/nvim-ts-rainbow",
      config = require("config.nvim-ts-rainbow"),
      requires ={ "nvim-treesitter/nvim-treesitter" }
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = require("config.nvim-colorizer"),
    }

    -- themes
    -- load these with `lua require("config.theme")("foo", "bar") in your init.vim`
    use 'marko-cerovac/material.nvim'
    use "rafamadriz/neon" -- doom like (+treesiter +lsp)


    ----------------------------------------------------------------------------
    --                             TELESCOPE                                  --
    ----------------------------------------------------------------------------

    use {
      'lifer0se/ezbookmarks.nvim',
      after = 'telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope.nvim',
      },
      config = function()
        require('ezbookmarks').setup{
          cwd_on_open = 0,        -- change directory when opening a bookmark
          use_bookmark_dir = 0,   -- if a bookmark is part of a bookmarked directory, cd to that direcrtory (works independently of cwd_on_open)
          open_new_tab = 0,       -- open bookmark in a new tab.
        }
        local opts = { silent = true }
        vim.api.nvim_set_keymap('n', '<leader>,', ':lua require"ezbookmarks".AddBookmark()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>,,', ':lua require"ezbookmarks".RemoveBookmark()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>j', ':lua require"ezbookmarks".OpenBookmark()<CR>', opts)
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
	    requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'kyazdani42/nvim-web-devicons'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        {'nvim-telescope/telescope-project.nvim'},
      },
      config = require("config.telescope")
    }
    use {
      'sudormrfbin/cheatsheet.nvim',
      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      },
      config = require("config.cheatsheet")
    }


    use {
	    "folke/todo-comments.nvim", -- treesitter required for proper highlighting
	    requires = {{'nvim-lua/plenary.nvim'}, {'nvim-treesitter/nvim-treesitter'}},
	    config = require("config.todo-comments"),
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = require("config.gitsigns"),
    }
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons'},
      config = require("config.lualine")
    }
    use {
      'phaazon/hop.nvim',
      as = 'hop',
      config = require("config.hop"),
    }
    use {
      -- NOTE: requires: a theme that supports LSP diagnostics, else lsp-colors plugin; a patched font; LSP;
      "folke/trouble.nvim",
      requires = {'kyazdani42/nvim-web-devicons'},
      config = require("config.trouble"),
    }
    use {
      'mhartington/formatter.nvim',
      config = require("config.formatter"),
      run = function()
        npm.sync("prettier")
        npm.sync("@fsouza/prettierd")
      end,
    }
    use {
      'mfussenegger/nvim-lint',
      disable = true,
      config = require("config.nvim-lint"),
      run = function()
        npm.sync("eslint_d")
        npm.sync("@typescript-eslint/eslint-plugin")
      end,
    }
  end,

  -- Packer config
  config = require("config.packer")
})
