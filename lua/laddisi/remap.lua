vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
