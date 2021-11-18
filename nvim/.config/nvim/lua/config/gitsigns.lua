return function()
  require('gitsigns').setup {
    -- generally speaking frequently polling the repo is a performance hog.
    current_line_blame = false, -- HUGE performance hog, laggy input
    update_debounce = 1000, -- does this really need to be 100ms (default)? use 1k instead
  }
end
