local M = {}

function M.try_require(path)
  local status, module = pcall(require, path)
  if status then return module else return nil end
end

function M.is_mode(mode)
  if vim.api.nvim_get_mode().mode == mode then return true end
  return false
end

return M
