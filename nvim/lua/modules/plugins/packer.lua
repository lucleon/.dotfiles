-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Lsp
    use({
        'neovim/nvim-lspconfig',
    })

  -- Completion
    use({
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-rg',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    })

-- Snippets
    use({
        'L3MON4D3/luasnip',
        requires = {
            'rafamadriz/friendly-snippets',
        },
    })

    use({
      'nvim-treesitter/nvim-treesitter',
    })

  -- colorscheme
  use { "catppuccin/nvim", as = "catpuccin" }

  -- Dev div tools
    use({
        'RRethy/vim-illuminate',
    })

  -- fuzzy finder
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- git
  use("tpope/vim-fugitive")

  -- markdown
	use({
	    "iamcco/markdown-preview.nvim",
	    run = function() vim.fn["mkdp#util#install"]() end,
	})

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- icons
  use 'nvim-tree/nvim-web-devicons'
end)
