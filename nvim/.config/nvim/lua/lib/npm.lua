local sys = require("lib.sys")
local fs = require("lib.fs")


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


-- Get the local NPM bin directory. If you pass in a module name, it will
-- append it to the path.
-- bin() => /foo/node_modules/.bin
-- bin("module") => /foo/node_modules/.bin/module
-- It will return nil if LSP is not attached (so cannot find workspace root)
-- or if node_modules/.bin doesn't exist
function M.bin(module)
  local root = fs.root_dir()
  if (root and fs.is_dir(root)) then -- has workspace
    local bin = fs.join(root, "node_modules", ".bin")
    if (fs.is_dir(bin)) then -- has local npm
      if not module then return bin end -- only bin path wanted
      local path = fs.join(bin, module)
      if not fs.exists(path) then -- module not found
        print("npm.bin(): local module NOT FOUND: '"..module.."'. You must install it into your local repo.")
        return nil
      end
      return path
    end
  else
    print("npm.bin(): cannot find workspace root, ensure LSP is attached.")
  end
  return nil
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
