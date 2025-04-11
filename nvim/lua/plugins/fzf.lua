return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    require("fzf-lua").setup(
      {
        "fzf-native",
        winopts = {
          preview = { default = 'bat' },
        },
      }
    )
    vim.keymap.set('n', '<leader>ff', require("fzf-lua").files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ps', require("fzf-lua").grep, { desc = 'Grep String' })
  end
}
