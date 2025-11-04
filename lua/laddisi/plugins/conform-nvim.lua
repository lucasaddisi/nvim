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
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { lsp_format = "fallback", timeout_ms = 500 }
            end,
            --log_level = vim.log.levels.DEBUG
        })

        -- Custom commands for enabling and disabling autoformat
        -- See https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end
}
