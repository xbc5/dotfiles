local severities = {
  vim.lsp.protocol.DiagnosticSeverity.Warning,
  vim.lsp.protocol.DiagnosticSeverity.Error,
}


-- sometimes line/char numbers are nil. You also need to offset them by -1.
local function fix(v, default)
  if type(v) == 'number' then return v-1 end
  return assert(
    default,
    "You must assign a valid default, line/column numbers cannot be: "..type(default)
  )
end


return {
  cmd = 'eslint_d',
  stdin = true, -- accepts stdin, else file name added to args automatically
  args = {"--stdin", "--format", "json"}, -- can also be zero arg funcs.
  stream = 'stdout', -- the expected output stream of the linter.
  ignore_exitcode = false, -- true if non-zero exit code is normal.
  parser = function(output)
    local decoded = vim.fn.json_decode(output)[1]
    local diagnostics = {}
    if not decoded then return diagnostics end
    local messages = decoded.messages

    for _, item in ipairs(messages or {}) do
      table.insert(diagnostics, {
        range = {
          ['start'] = {
            line = fix(item.line),  -- these don't need a default, line number|column is always defined.
            character = fix(item.column),
          },
          ['end'] = {
            line = fix(item.endLine, item.line), -- these NEED a default, sometimes end* is nil.
            character = fix(item.endColumn, item.column), -- default to same line/column.
          },
        },
        severity = assert(severities[item.severity], 'missing mapping for severity '..item.severity),
        message = item.message,
        code = item.ruleId,
        source = "eslint",
      })
    end
    return diagnostics
  end,
}
