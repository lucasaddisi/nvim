return {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            diagnostics = {
                disable = { 'missing-fields' },
                globals = { 'vim' }
            },
        },
    },
}
