vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config.lazy')

--vim.lsp.config('luals', {
--  on_init = function()
--    print('luals now runs in the background')
--  end,
--})
vim.lsp.enable({
  'basedpyright',
  'clangd',
  'luals'
})
