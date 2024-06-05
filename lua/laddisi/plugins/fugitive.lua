return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set({'n', 'v'}, "<leader>gb", "<Cmd>Git blame<CR>")
        vim.keymap.set({'n', 'v'}, "<leader>gd", "<Cmd>Gvdiffsplit<CR>")
        vim.keymap.set({'n', 'v'}, "<leader>gad", "<cmd>Git! difftool<cr>")
    end
}
