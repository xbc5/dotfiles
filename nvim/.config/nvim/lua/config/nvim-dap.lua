return function()
  local dap = require("dap")

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/git/vscode-node-debug2/out/src/nodeDebug.js'},
  }


  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/git/vscode-chrome-debug/out/src/chromeDebug.js"}
  }


  dap.configurations.javascript = {
    {
      type = 'node2',
      request = 'launch',
      program = '${workspaceFolder}/${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
        type = "chrome",
        request = "attach",
        program = "${workspaceFolder}/${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
  }
end
