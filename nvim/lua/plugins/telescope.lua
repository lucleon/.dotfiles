--local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
      dependencies = {'nvim-lua/plenary.nvim'},
      keys = {
        {
          '<leader>ff',
          function()
            require('telescope.builtin').find_files()
          end,
        }
      }
}

