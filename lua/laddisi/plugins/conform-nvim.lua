return {
    'stevearc/conform.nvim', -- https://github.com/stevearc/conform.nvim
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                ["lua"] = { "stylua" },
                ["markdown"] = { "prettier" },
                ["javascript"] = { "prettier" },
                ["javascriptreact"] = { "prettier" },
                ["typescript"] = { "prettier" },
                ["typescriptreact"] = { "prettier" },
                ["json"] = { "prettier" },
                ["html"] = { "prettier" },
                ["xml"] = { "xmlformatter" }
            },
            format_on_save = {
                lsp_format = "prefer"
            },
            vim.keymap.set('n', '<leader>=', function()
                require('conform').format()
            end)
        })
    end
}
