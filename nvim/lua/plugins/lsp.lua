return {
  {'VonHeikemen/lsp-zero.nvim', 
    branch = 'v3.x',
    dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset('recommend')

      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          {name = 'nvim_lsp'},
        }
      })

      --local cmp_mappings = lsp.defaults.cmp_mappings({
      --  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      --  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      --  ['<C-y>'] = cmp.mapping.confirm( {select = true}),
      --  ["<C-Space>"] = cmp.mapping.complete(),
      --})

      --lsp.setup_nvim_cmp({
      --  mapping = cmp_mappings
      --})

      lsp.on_attach(function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      end)

      local lsp_zero = require('lsp-zero')
      require('mason').setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "pyright", "clangd"},
        handlers = {
          lsp_zero.default_setup,
          pyright = function()
            require('lspconfig').pyright.setup({
              settings = {
                completions = {
                  completeFunctionCalls = true
                }
              }
            })
          end,
          clangd = function()
            require('lspconfig').clangd.setup({
              settings = {
                completions = {
                  completeFunctionCalls = true
                }
              }
            })
          end,
        },
      })
    end },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
}
