return {
    "mfussenegger/nvim-dap",
    config = function ()
        local dap = require('dap')
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
        vim.keymap.set('n', '<F7>', dap.step_into)
        vim.keymap.set('n', '<F8>', dap.step_over)
        vim.keymap.set('n', '<F9>', dap.continue)

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
