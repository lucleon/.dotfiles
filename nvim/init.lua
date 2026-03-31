vim.g.mapleader = ','

local ui = require('config.ui')

vim.opt.completeopt:append('noselect')

require('config.options')
require('config.mappings')
require('config.autocmds')
require('config.lsp')
