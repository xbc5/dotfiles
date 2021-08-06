local M = {}


-- Install all third-party dependencies.
function M.install()
  require("config.nvim-lspinstall").install()
end


return M
