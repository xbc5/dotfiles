local M = {}


-- Pass a list initially, then check for a value's existence. DON'T pass in a k/v table,
--  because all values are reset.
-- @example has({"one", "two"})("one") => true
function M.has(t)
  local new = {}
  for _, i in ipairs(t) do
    new[i] = true
  end
  return function(value) return new[value] or false end
end

function M.merge(t1, t2)
  for k,v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

return M
