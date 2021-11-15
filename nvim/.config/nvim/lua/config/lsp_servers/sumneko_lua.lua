local M = {}

function M.config()
  return {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
        },
      },
    },
  }
end

return M
