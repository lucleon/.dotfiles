local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

require('lspconfig').ruff.setup({
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Server settings should go here
      logLevel = 'debug',
    }
  }
})
