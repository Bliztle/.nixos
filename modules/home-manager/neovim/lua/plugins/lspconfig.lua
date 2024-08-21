local lspconfig = require('lspconfig')
local pid = vim.fn.getpid()

-- local on_attach = function(client, bufnr)
--     if client.server_capabilities.document_highlight then
--         vim.api.nvim_exec([[
--             -- hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
--             -- hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
--             -- hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
--             augroup lsp_document_highlight
--                 autocmd! * <buffer>
--                 autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--                 autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--             augroup END
--         ]], false)
--     end
-- end

-- Language servers
-- Lua
-- lspconfig.lua_language_server.setup {}

-- c
lspconfig.clangd.setup {}
-- C#
lspconfig.omnisharp.setup {
    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(pid) },
    enable_roslyn_analyzers = true,
    enable_import_completion = true
}
-- Haskell
lspconfig.hsl.setup {
    cmd = { 'haskell-language-server-wrapper', '--lsp' }
}
-- JavaScript / Typescript
lspconfig.tsserver.setup {}
lspconfig.eslint.setup {}
lspconfig.svelte.setup {}
vim.g['prettier#autoformat'] = 0
vim.g['prettier#autoformat_require_pragma'] = 0
vim.g['prettier#autoformat_config_present'] = 1
-- Lua
lspconfig.lua_ls.setup {}
-- Nix
lspconfig.nil_ls.setup {}
-- Rust
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            -- checkOnSave = {
            --     command = "cargo clippy -- -Wclippy::pedantic"
            -- }
            check = {
                command = "clippy",
                extraArgs = { "--", "-W", "clippy::pedantic" }
                -- command = "clippy -- -W clippy::pedantic"
            }
        },
    },
}

-- Global mappings
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dN', vim.diagnostic.open_float)

-- Auto format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Attached
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings
        -- See :help vim.lsp.* for documentation
        local opts = { buffer = ev.buf }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        if client.server_capabilities.document_highlight then
            vim.api.nvim_exec([[
                hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
                hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
                hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
        end
    end,
})
