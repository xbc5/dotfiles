return function()
  local emmet = require("config.emmet-ls")
  local lspi = require('lspinstall')

  emmet.create() -- create an installable emmet server, you must manually install it after

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
