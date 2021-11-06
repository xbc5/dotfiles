local ppath = require("plenary.path")

local M = {}

-- Get the workspace root directory.
function M.root_dir()
  return vim.lsp.buf.list_workspace_folders()[1]
end

function M.is_dir(path)
   return ppath:new(path):is_dir()
end

return M
