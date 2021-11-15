local M = {}

function M.try_require(path)
  local status, module = pcall(require, path)
  if status then return module else return nil end
end

return M
