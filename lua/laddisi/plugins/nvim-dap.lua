return {
    "mfussenegger/nvim-dap",
    config = function ()
        local dap = require('dap')
        local widgets = require('dap.ui.widgets')

        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
        vim.keymap.set('n', '<leader>dv', function () widgets.sidebar(widgets.scopes, {height=30}, 'belowright split').open() end)
        vim.keymap.set("n", "<leader>ds", dap.repl.open) -- (d)ebugger (s)how
        vim.keymap.set("n", "<leader>rl", dap.run_last) -- (r)un (l)ast
        vim.keymap.set('n', '<F7>', dap.step_into)
        vim.keymap.set('n', '<F8>', dap.step_over)
        vim.keymap.set('n', '<F9>', dap.continue)

        -- Configure an autocommand to attach autocomplete to REPL
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dap-repl",
            callback = function()
                require('dap.ext.autocompl').attach()
            end
        })

        dap.configurations.java = {
            {
                name = "Debug (Attach) - Remote";
                request = "attach";
                type = 'java';
                hostname = "127.0.0.1";
                port = 5005;
            },
        }

    end
}
