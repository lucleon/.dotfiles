local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local M = {
  setup = function(on_attach, capabilities)
    require('lspconfig').pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities, 
    })
  end,

}

return M
