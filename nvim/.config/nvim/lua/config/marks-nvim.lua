local M = {}

function M.config()
  require'marks'.setup {
    builtin_marks = { ".", "<", ">", "^" },
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = true,
    -- how often (in ms) to redraw signs/recompute mark positions. 
    -- higher values will have better performance but may cause visual lag, 
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  }
end

return M

