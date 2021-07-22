return function()
  vim.api.nvim_exec([[
    augroup NvimLint
      autocmd!
      autocmd BufWritePost <buffer> lua require('lint').try_lint()
    augroup END
  ]], true)


  require("lint").linters_by_ft = {
    typescript = {'eslint_d'} -- my own linter @ [lua/]lint/linter/eslint.lua
  }
end
