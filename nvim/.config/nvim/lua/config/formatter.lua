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
  vim.api.nvim_exec([[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.js,*.ts,*.rs,*.lua FormatWrite
    augroup END
  ]], true)

  -- TODO: conditionally load these formatters, and load a local config.
  -- you don't want to auto-format a code-base that isn't yours.
  require('formatter').setup({
    logging = false,
    filetype = {
      javascript = {
        function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      typescript = {
        function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      cpp = {
        function()
          return {
            exe = "clang-format",
            args = {},
            stdin = true,
            cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
          }
        end
      }
    }
  })
  
end
