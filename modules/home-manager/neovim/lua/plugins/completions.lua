local cmp = require('cmp')
local lspkind = require('lspkind')

-- General completions
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behaviour = cmp.ConfirmBehavior.Replace
        }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' }
    }),
    formatting = {
        format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
    }
})

-- Specific completions
-- -- Git
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'git' },
--     }, {
--         { name = 'buffer' }
--     })
-- })
-- -- Searching
-- cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })
-- -- Path and cmd in :
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = 'path' },
--     }, {
--         { name = 'cmdline' }
--     }),
--     matching = { disallow_symbol_nonprefix_matchhing = false }
-- })

-- Example configuration includes some capabilities set for each lsp server,
-- but i do now know if they are required or not
-- https://github.com/hrsh7th/nvim-cmp?tab=readme-ov-file
