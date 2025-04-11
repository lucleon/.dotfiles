return {
  on_attach = function(client, bufnr)
    -- Your on_attach code here
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  -- Additional settings
}
