vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    -- Feed this client's candidates into Neovim's builtin completion.
    -- 'autocomplete' (options.lua) shows them while typing.
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
vim.keymap.set('i', '<C-Space>', function()
  vim.lsp.completion.get()
end, { desc = 'Trigger completion' })

-- Only accept with <CR> when an item was explicitly selected (Tab/C-n), so
-- plain Enter still inserts a newline while the menu is open.
vim.keymap.set('i', '<CR>', function()
  local selected = vim.fn.complete_info({ 'selected' }).selected
  return selected ~= -1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Accept selected completion' })

vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true, desc = 'Next completion item' })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, desc = 'Previous completion item' })
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
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({count=-1, float=true})
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({count=1, float=true})
end)
