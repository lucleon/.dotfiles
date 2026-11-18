vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-tree/nvim-web-devicons', -- optional
})

local fzf = require('fzf-lua')

fzf.setup({
  winopts = {
    preview = { default = 'bat' },
  },
})

vim.keymap.set('n', '<leader>ff', function()
  fzf.files({
    cwd = vim.fn.getcwd(),
    fd_opts = '--color=never --type f --type l '
      .. '--exclude .git --exclude .jj '
      .. '--exclude build --exclude install --exclude log '
      .. '--exclude .cache',
  })
end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', function()
  fzf.live_grep({ cwd = vim.fn.getcwd() })
end, { desc = '[F]ind [G]rep' })

vim.keymap.set('n', '<leader>fw', function()
  fzf.grep_cword({ cwd = vim.fn.getcwd() })
end, { desc = '[F]ind [W]ord' })
vim.keymap.set('n', '<leader>gd', fzf.lsp_definitions)
vim.keymap.set('n', '<leader>gr', fzf.lsp_references)
vim.keymap.set('n', '<leader>ds', fzf.lsp_document_symbols)
