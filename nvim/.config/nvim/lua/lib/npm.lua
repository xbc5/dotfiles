local sys = require("lib.sys")


local M = {}

-- Check that a package exists globally. Be aware that this will return true if the package name is lib,
--  it's because NPM for some reason returns lib/ in global packages list. I don't care to fix this
--  it's a minor issue.
function M.pkg_exists(pkg)
  local f = io.popen("npm ls --global --parseable --depth=0  2>/dev/null | grep -E '"..pkg.."$'")

  local len = 0
  local exists = false
  for line in f:lines() do
    if sys.shell_cmd("basename "..line) == pkg then exists = true end
    len = len + 1
  end

  f:close()
  assert(len <= 1, "More than one package found for '"..pkg.."', be more specific or fix conflicts.")
  return exists
end


function M.install(pkg)
  sys.shell_cmd("npm i -g "..pkg, "QUIET")
end


function M.update(pkg)
  sys.shell_cmd("npm update -g "..pkg, "QUIET")
end


function M.sync(pkg)
  if not M.pkg_exists(pkg) then
    M.install(pkg)
  else
    M.update(pkg)
  end
end


return M
