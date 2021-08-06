-- create an installable emmet server, you must manually install it after
-- this must be available for the following functions, otherwise it cannot be configured/setup.
require("config.emmet-ls").create()


local M = {}


-- Install the language servers. Typically you will call this after setting up a new system.
function M.install()
  local lspi = require('lspinstall')
  local servers = {
    "go", "yaml", "css", "tailwindcss", "typescript", "svelte", "lua", "cmake", "dockerfile",
    "emmet", "terraform", "html", "vim", "python", "bash", "json", "rust",
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
      require('lspconfig')[server].setup(configs[server])
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
