---@type vim.lsp.Config  
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  init_options = {
    -- vim.empty_dict() keeps this an empty JSON object; a plain `{}` would be
    -- encoded as `[]`, which Ruff rejects.
    settings = vim.empty_dict(),
  },
}
