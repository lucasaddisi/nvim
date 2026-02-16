return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        "nvim-telescope/telescope.nvim",

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} }
    },
    config = function()
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local telescope = require('telescope.builtin')
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', function()
                    telescope.lsp_implementations({ show_line = true })
                end, opts)
                vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                --                 vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gr', function()
                    telescope.lsp_references({ show_line = false })
                end, opts)
                vim.keymap.set('n', '<leader>=', function()
                    vim.lsp.buf.format { async = true }
                end, opts)

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = ev.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = ev.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- Mason setup (for installation only)
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        require("mason-lspconfig").setup {
            automatic_enable = true,
            -- Automatically instals LSPs
            ensure_installed = { "lua_ls", "lua_ls", "jdtls" },
        }
    end,
}
