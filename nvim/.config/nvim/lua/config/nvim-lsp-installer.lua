local M = {}


-- Call this function with LspInstallPreferred, you don't need to manually call it anywhere. This
-- will only install servers that are not installed. You can update servers via LspInstallInfo.
function M.install()
  local installer = require'nvim-lsp-installer.servers'

  local servers = {
    "gopls", "yamlls", "cssls", "tailwindcss", "tsserver", "svelte", "sumneko_lua", "cmake", "dockerls",
    "emmet_ls", "terraformls", "html", "vimls", "pyright", "bashls", "jsonls", "rust_analyzer", "eslint"
  }

  for _, server in pairs(servers) do
    local available, s = installer.get_server(server)
    if available and not s:is_installed() then
      print("LspInstall: installing "..server.."..")
      s:install()
    end
    if not available then print('LSP server not available: '..server) end
  end
end

-- You need to put config modules under 'config.lsp_servers.SERVER_NAME.lua', and export
-- a config() function, and possibly a setup() function if you add that feature in the future.
-- You can also use the LspInstallPreferred command to install the listed servers above
-- if they're not already installed.
function M.config()
  local lsp_installer = require("nvim-lsp-installer")

  vim.cmd('command! LspInstallPreferred lua require("config.nvim-lsp-installer").install()')

  lsp_installer.settings{
    log_level = vim.log.levels.INFO,
  }

  lsp_installer.on_server_ready(function(server)
      local nvim = require("lib.nvim")
      local opts = {}
      local name = server.name -- the EXACT LSP server name

      -- the server config might not exists
      local path = 'config.lsp_servers.'..name
      local conf = nvim.try_require(path)
      if conf then
        if not conf.config then
          print("nvim-lsp-installer: error loading config() for the LSP server config: "..path)
        else
          opts = conf.config()
        end
      end
      -- NOTE: you can do lsp server setup() here too if there's a need for it.
      -- optionally export a setup() function from config modules.

      -- This setup() function is exactly the same as lspconfig's setup function.
      -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      server:setup(opts)
  end)
end

return M
