-- Setup nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')
lspkind.init()

vim.opt.completeopt = { "menu", "menuone", "noselect" }


cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm(),
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        },
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'path' },
                { name = 'buffer', keyword_length = 5, option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                }},
            }),
        formatting = {
            format = lspkind.cmp_format({with_text = true, maxwidth = 50})
        },
        experimental = {
            native_menu = false,
        },
    })
