return {
  {
    'williamboman/mason.nvim',
    lazy = false,
      config = function()
      require("mason").setup()
    end,

  },
  {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
      },
    })

    -- Optional: Setup cmdline completion
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
},
{
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')

    -- Ensure the servers you want are installed
    mason_lspconfig.setup({
      ensure_installed = {
        'lua_ls',
        'bashls',
        'clangd',
        'dockerls',
        'basedpyright',
        'ruff',
      },
    })

    -- Setup handlers for the LSP servers
    mason_lspconfig.setup_handlers({
      function(server_name)
        local opts = {}

        -- Check if there's a custom config for the server
        local has_custom_opts, server_custom_opts = pcall(require, 'lsp.' .. server_name)
        if has_custom_opts then
          opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
        end

        -- Setup the server with the options
        lspconfig[server_name].setup(opts)
      end,
    })
  end,
},

}

