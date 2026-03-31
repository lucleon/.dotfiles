vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/windwp/nvim-ts-autotag',
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local data = ev.data
    if data.spec.name ~= 'nvim-treesitter' or data.kind ~= 'update' then
      return
    end

    if not data.active then
      vim.cmd.packadd('nvim-treesitter')
    end

    vim.cmd('TSUpdate')
  end,
})

require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
  'bash',
  'c',
  'cpp',
  'cmake',
  'lua',
  'python',
  'vim',
  'vimdoc',
  'markdown',
  'markdown_inline',
  'query',
})

vim.treesitter.language.register('cpp', 'hpp')
vim.treesitter.language.register('c', 'h')
