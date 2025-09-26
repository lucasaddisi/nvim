return {
    'stevearc/conform.nvim', -- https://github.com/stevearc/conform.nvim
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                ["lua"] = { "stylua" },
                ["markdown"] = { "prettier" },
                ["javascript"] = { "prettier" },
                ["javascriptreact"] = { "prettier" },
                ["java"] = { "google-java-format" },
                ["typescript"] = { "prettier" },
                ["typescriptreact"] = { "prettier" },
                ["json"] = { "prettier" },
                ["html"] = { "prettier" },
                ["xml"] = { "xmlformatter" }
            },
            formatters = {
                xmlformatter = { args = { "--indent", "4", "-" } },
            },
            format_on_save = {
                lsp_format = "fallback"
            },
            vim.keymap.set('n', '<leader>=', function()
                require('conform').format()
            end),
            --log_level = vim.log.levels.DEBUG
        })
    end
}
