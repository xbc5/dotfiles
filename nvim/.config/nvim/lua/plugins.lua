local sys = require("lib.sys")
-- FIXME: this uses plenary, and causes panic on new profile init becuase it doesn't exist
-- local npm = require("lib.npm")

-- don't run any installations as root or in Qubes templates
-- NOTE: make sure that this is the root of all of your plugin configuration, because
--  it will not run under Qubes templates, or as root. It must not break anything if it
--  doesn't run.
if not sys.is_user() or sys.is_templatevm() then return end

-- auto compile after updating this file;
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

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
    use "nvim-lua/plenary.nvim" -- packer opt is buggy, make this mandatory
    use 'wbthomason/packer.nvim' -- manage packer updates
    use 'vim-scripts/loremipsum'
    use 'b3nj5m1n/kommentary'
    use "tpope/vim-surround"
    use 'j-hui/fidget.nvim'
    use 'marko-cerovac/material.nvim'

    use {
      'numtostr/FTerm.nvim',
      config = require'config.fterm-nvim'.config
    }

    use {
      'kevinhwang91/rnvimr',
      config = require'config.rnvimr'.config,
    }

    use {
      'chentau/marks.nvim',
      config = require'config.marks-nvim'.config,
    }


    use {
      'williamboman/nvim-lsp-installer',
      requires = { "neovim/nvim-lspconfig" },
    }


    use {
      "mfussenegger/nvim-ts-hint-textobject",
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "nvim-treesitter",
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "nvim-treesitter",
    }

    use {
      'nvim-treesitter/nvim-treesitter',
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
      "weirongxu/plantuml-previewer.vim",
      requires = { "aklt/plantuml-syntax", "tyru/open-browser.vim" }
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = require("config.nvim-colorizer"),
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
      config = require("config.telescope"),
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
	    "folke/todo-comments.nvim",
	    requires = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-treesitter/nvim-treesitter'}
      },
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
      'mhartington/formatter.nvim',
      config = require("config.formatter"),
      run = function()
        -- FIXME: conditionally check if npm exists, it might not
        --npm.sync("prettier")
        --npm.sync("@fsouza/prettierd")
      end,
    }

    use {
      'mfussenegger/nvim-lint',
      disable = true,
      config = require("config.nvim-lint"),
      run = function()
        -- FIXME: conditionally check if npm exists, it might not
        --npm.sync("eslint_d")
        --npm.sync("@typescript-eslint/eslint-plugin")
      end,
    }
  end,

  config = require("config.packer")
})
