--local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
      dependencies = {'nvim-lua/plenary.nvim'},
      keys = {
        {
          '<leader>ff',
          function()
            require('telescope.builtin').find_files()
          end,
        },
        {
          '<C-p>',
          function()
            require('telescope.builtin').git_files()
          end,
        },
        {
          '<leader>ps',
          function()
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
          end,
        }
      }
    }
