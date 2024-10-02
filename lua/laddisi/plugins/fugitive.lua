return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb"
    },
    config = function()
        vim.keymap.set({'n', 'v'}, "<leader>gb", "<Cmd>Git blame<CR>")
        vim.keymap.set({'n', 'v'}, "<leader>gd", "<Cmd>Gvdiffsplit<CR>") -- Opens vimdiff. dp (diffput) do (diffobtain)
        vim.keymap.set({'n', 'v'}, "<leader>go", "<Cmd>GBrowse<cr>") -- g(it) o(open) - Open file in the browser 
        vim.keymap.set({'n', 'v'}, "<leader>gc", "<Cmd>GCommit<cr>") -- g(it) o(open) - Open file in the browser 
        vim.keymap.set({'n', 'v'}, "<leader>gs", "<Cmd>Git<cr>") -- g(it) s(status) - Open fugitive interactive prompt
    end
}

