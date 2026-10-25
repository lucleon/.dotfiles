---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
  settings = {
    python = {
      -- virtualenvwrapper env used for the Django project. If a project has
      -- its own `.venv`, basedpyright would normally pick that up, but an
      -- explicit pythonPath wins, so adjust or remove this per project.
      pythonPath = vim.fn.expand('~/.virtualenvs/djangodev/bin/python'),
    },
    basedpyright = {
      -- Ruff owns import organising (I001).
      disableOrganizeImports = true,
      analysis = {
        -- basedpyright defaults to "recommended", which expects full typing
        -- everywhere. "standard" is pyright's normal level.
        typeCheckingMode = 'standard',
        diagnosticMode = 'openFilesOnly',
        diagnosticSeverityOverrides = {
          -- These overlap with Ruff rules; keep a single source of truth.
          reportUnusedImport = 'none',               -- Ruff F401
          reportDuplicateImport = 'none',            -- Ruff F811
          reportUnusedVariable = 'none',             -- Ruff F841
          reportWildcardImportFromLibrary = 'none',  -- Ruff F403
        },
      },
    },
  },
}
