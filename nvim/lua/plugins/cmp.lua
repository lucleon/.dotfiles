-- https://github.com/hrsh7th/nvim-cmp
return{
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'lukas-reineke/cmp-under-comparator',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'lukas-reineke/cmp-rg',
    {
        'onsails/lspkind-nvim',
        config = function()
            require('lspkind').init()
        end,
    },
  },
  config = function()
      local cmp = require('cmp')
      local cmp_buffer = require('cmp_buffer')
      local compare = require('cmp.config.compare')
      local luasnip = require('luasnip')
      local icons = {
          Array = '  ',
          Boolean = '  ',
          Class = '  ',
          Color = '  ',
          Constant = '  ',
          Constructor = '  ',
          Enum = '  ',
          EnumMember = '  ',
          Event = '  ',
          Field = '  ',
          File = '  ',
          Folder = '  ',
          Function = '  ',
          Interface = '  ',
          Key = '  ',
          Keyword = '  ',
          Method = '  ',
          Module = '  ',
          Namespace = '  ',
          Null = ' ﳠ ',
          Number = '  ',
          Object = '  ',
          Operator = '  ',
          Package = '  ',
          Property = '  ',
          Reference = '  ',
          Snippet = '  ',
          String = '  ',
          Struct = '  ',
          Text = '  ',
          TypeParameter = '  ',
          Unit = '  ',
          Value = '  ',
          Variable = '  ',
        }
        luasnip.config.setup({})

        cmp.setup({
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, item)
                    item.kind = string.format('%s', icons[item.kind])
                    item.menu = ({
                        buffer = '[Buffer]',
                        luasnip = '[Snip]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[API]',
                        path = '[Path]',
                        rg = '[RG]',
                    })[entry.source.name]
                    return item
                end,
            },
            window = {
                completion = {
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
                documentation = {
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
            }, {
                {
                    name = 'buffer',
                    option = {
                        -- Complete from all visible buffers.
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { 
                  name = 'path',
                  option = {
                    trailing_slash = true,
                  },
                },
            }),
            sorting = {
                comparators = {
                    -- Sort by distance of the word from the cursor
                    -- https://github.com/hrsh7th/cmp-buffer#locality-bonus-comparator-distance-based-sorting
                    function(...)
                        return cmp_buffer:compare_locality(...)
                    end,
                    compare.offset,
                    compare.exact,
                    compare.score,
                    require('cmp-under-comparator').under,
                    compare.recently_used,
                    compare.locality,
                    compare.kind,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            },
        })
      end,
}
-- local u = require('utils')
-- local cmp_ok, cmp = pcall(require, 'cmp')
-- local luasnip_ok, luasnip = pcall(require, 'luasnip')
-- local cmp_autopair_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

--[[
if not cmp_ok then
    u.notif('Plugins :', 'Something went wrong with nvim-cmp', vim.log.levels.WARN)
    return
else
    cmp.init({
        snippet = {
            expand = function(args)
                if luasnip_ok then
                    luasnip.lsp_expand(args.body)
                else
                    return
                end
            end,
        },
        formatting = {
            format = function(entry, item)
                local menu_map = {
                    buffer = '[Buf]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[API]',
                    path = '[Path]',
                    luasnip = '[Snip]',
                    rg = '[RG]',
                }

                item.menu = menu_map[entry.source.name] or string.format('[%s]', entry.source.name)
                item.kind = vim.lsp.protocol.CompletionItemKind[item.kind]

                return item
            end,
        },
        window = {
            completion = {
                border = 'rounded',
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            },
            documentation = {
                border = 'rounded',
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
            },
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete()),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-n>'] = {
                c = function(fallback)
                    local cmp = require('cmp')
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            },
            ['<C-p>'] = {
                c = function(fallback)
                    local cmp = require('cmp')
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            },
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp', priority = 5, max_item_count = 5 },
            { name = 'buffer', priority = 4, max_item_count = 4 },
            { name = 'rg', priority = 3, max_item_count = 3 },
            { name = 'luasnip', priority = 2, max_item_count = 3 },
            { name = 'path', priority = 1, max_item_count = 5 },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
        }),
    })
end

-- https://github.com/windwp/nvim-autopairs
local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')

if autopairs_ok then
    autopairs.init()
end]]
