return {
  on_attach = function(client, bufnr)
    -- Custom on_attach actions specific to clangd can be added here
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  -- Additional clangd-specific settings can be included here
}

