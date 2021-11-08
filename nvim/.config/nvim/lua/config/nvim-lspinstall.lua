-- create an installable emmet server, you must manually install it after
-- this must be available for the following functions, otherwise it cannot be configured/setup.
require("config.emmet-ls").create()
local table = require("lib.table")


local M = {}

-- You must run this before lspi.setup()
local function registerEslint()
  -- 1. get the default config from nvim-lspconfig
  local config = require"lspinstall/util".extract_config("eslint")
  -- 2. update the cmd. relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
  config.default_config.cmd[1] = "./node_modules/.bin/vscode-eslint-language-server"

  -- 3. extend the config with an install_script and (optionally) uninstall_script
  require'lspinstall/servers'.eslint = vim.tbl_extend('error', config, {
    -- lspinstall will automatically create/delete the install directory for every server
    install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install vscode-langservers-extracted@latest
    ]],
    uninstall_script = nil -- can be omitted
  })
end
registerEslint()


-- Install the language servers. Typically you will call this after setting up a new system.
function M.install()
  local lspi = require('lspinstall')
  local servers = {
    "go", "yaml", "css", "tailwindcss", "typescript", "svelte", "lua", "cmake", "dockerfile",
    "emmet", "terraform", "html", "vim", "python", "bash", "json", "rust", "eslint"
  }

  local has = require("lib.table").has(servers)
  for _, server in pairs(servers) do
    if not has(server) then
      print("LspInstall: installing "..server.."..")
      lspi.install_server(server)
    end
  end
end


function M.config()
  local lspi = require('lspinstall')

  local configs = {
    -- put any overrides you have in here, the key is the LSP 'server' name.
    lua = require("config.sumneko_lua"),
    emmet = require("config.emmet-ls").config,
  }
  setmetatable(configs, { __index = function () return {} end }) -- empty table default

  local function setup_servers()
    lspi.setup()
    local servers = lspi.installed_servers()
    for _, server in pairs(servers) do
      require('lspconfig')[server].setup(
        table.merge(
          configs[server],
          { on_attach = require"config.aerial".on_attach } -- symbol browser side-window
        ))
    end
  end
  setup_servers()

  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  lspi.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end
end


return M
