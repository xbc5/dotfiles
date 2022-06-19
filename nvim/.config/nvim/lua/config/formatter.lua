--[[
Each formatter should return a table that consiste of:
  exe: the program you wish to run
  args: a table of args to pass
  stdin: If it should use stdin or not.
  cwd : The path to run the program from.
  tempfile_dir: directory for temp file when not using stdin (optional)
  tempfile_prefix: prefix for temp file when not using stdin (optional)
  tempfile_postfix: postfix for temp file when not using stdin (optional)
]]--

return function()
  -- NOTE: don't forget to update this when adding new formatters.
  -- TODO: conditionally load these formatters, and load a local config.
  -- you don't want to auto-format a code-base that isn't yours.
  vim.api.nvim_exec([[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.js,*.ts,*.html FormatWrite
    augroup END
  ]], true)

  local config = {
    logging = false,
    filetype = {}
  }

  -- initialise prettierd
  for _, t in pairs({"html", "javascript", "typescript"}) do
    config.filetype[t] = {
      function()
        return {
          exe = "./node_modules/.bin/prettierd",
          args = {vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    }
  end

  require('formatter').setup(config)

end
