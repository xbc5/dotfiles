local const = require("lib.const")
local sys = require("lib.sys")


local M = {}


function M.pkg_exists(pkg)
  return sys.shell_cmd("npm ls -g | grep "..pkg, "NOERR") ~= ''
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
