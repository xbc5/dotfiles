local M = {}


function M.create()
  require('lspinstall/servers').emmet = {
    install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install emmet-ls
    ]],
    default_config = {
      cmd = { "./node_modules/.bin/emmet-ls", "--stdio" },
      filetypes = { 'html', 'css' },
      root_dir = require('lspconfig').util.root_pattern(".git", vim.fn.getcwd()),
    }
  }
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.config = { capabilities = capabilities; }


return M
