vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config')
require("lazy")
require("remap")
