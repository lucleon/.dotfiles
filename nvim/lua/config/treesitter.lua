require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
  'bash',
  'c',
  'cpp',
  'cmake',
  'css',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'jsonc',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
})

vim.treesitter.language.register('cpp', 'hpp')
vim.treesitter.language.register('c', 'h')

require('nvim-ts-autotag').setup()
