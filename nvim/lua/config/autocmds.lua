vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    -- completion (what you already have)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

    local map = function(keys, func)
      vim.keymap.set('n', keys, func, { buffer = buf })
    end

    map('gd', vim.lsp.buf.definition)
    map('gD', vim.lsp.buf.declaration)
    map('gr', vim.lsp.buf.references)
    map('gi', vim.lsp.buf.implementation)
    map('K', vim.lsp.buf.hover)
    map('<leader>rn', vim.lsp.buf.rename)
    map('<leader>ca', vim.lsp.buf.code_action)
    map('<leader>f', function() vim.lsp.buf.format({ async = true }) end)
  end,
})
vim.opt.completeopt = { 'menuone', 'popup', 'noselect' }
vim.keymap.set('i', '<C-Space>', function()
  vim.lsp.completion.get()
end)

vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true })

vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = '●',
  },
  float = {
    border = 'rounded',
  },
  severity_sort = true,
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
