local M = {}

function M.jest(...)
  local dap = require('dap')
  local args = {...}

  local path = args[1]
  if not path then
    print('You must provide a path as the first arg.')
  end

  -- i.e. stupid shift
  local rest = {}
  table.move(args, 2, #args, 1, rest)

  dap.run({
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    -- WARN: unpack() is deprecated; use table.unpack() when this blows up.
    runtimeArgs = {'--inspect-brk', './node_modules/.bin/jest', '--no-coverage', '--no-cache', unpack(rest, 1, #rest)},
    args = { path },
    sourceMaps = 'inline',
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
    disableOptimisticBPs = true
  })

end


function M.config()
  local dap = require('dap')

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/git/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  dap.configurations.javascript = {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require'dap.utils'.pick_process,
    },
  }

  dap.defaults.fallback.focus_terminal = true

  local map = vim.api.nvim_set_keymap
  local opts = { silent = true, noremap = true }

  map('n', '<leader>ec', '<Cmd>lua require("dap").run_to_cursor()<CR>', opts)
  map('n', '<leader>el', '<Cmd>lua require("dap").run_last()<CR>', opts)
  map('n', '<leader>ed', '<Cmd>lua require("dap").disconnect()<CR>', opts)
  map('n', '<leader>ex', '<Cmd>lua require("dap").close()<CR>', opts)
  map('n', '<leader>ep', '<Cmd>lua require("dap").pause()<CR>', opts) -- can take thread ID

  map('n', '<leader>J', '<Cmd>lua require("dap").continue()<CR>', opts) -- also starts session
  map('n', '<leader>K', '<Cmd>lua require("dap").reverse_continue()<CR>', opts) -- back in time
  map('n', '<leader>k', '<Cmd>lua require("dap").step_back()<CR>', opts) -- back 1 step
  map('n', '<leader>j', '<Cmd>lua require("dap").step_over()<CR>', opts)
  map('n', '<leader>h', '<Cmd>lua require("dap").step_out()<CR>', opts) -- out func
  map('n', '<leader>l', '<Cmd>lua require("dap").step_into()<CR>', opts) -- in func
  map('n', '<leader>u', '<Cmd>lua require("dap").up()<CR>', opts) -- up stack, no stepping
  map('n', '<leader>d', '<Cmd>lua require("dap").down()<CR>', opts) -- down stack, not stepping

  map('n', '<leader>eb', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
  map('n', '<leader>eB', '<Cmd>lua require("dap").clear_breakpoints()<CR>', opts)

  map('n', '<leader>er', '<Cmd>lua require("dap").repl.toggle()<CR>', opts)

  vim.cmd('command! -nargs=* JestDebug :lua require("config.dap").jest(<f-args>)')

end

return M
