return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb"
    },
    config = function()
        vim.keymap.set({'n', 'v'}, "<leader>gb", "<Cmd>Git blame<CR>")
        vim.keymap.set({'n', 'v'}, "<leader>gd", "<Cmd>Gvdiffsplit<CR>") -- Opens vimdiff. dp (diffput) do (diffobtain)
        vim.keymap.set({'n', 'v'}, "<leader>gad", "<Cmd>git! difftool<cr>") -- g(it) a(ll) d(differences)
        vim.keymap.set({'n', 'v'}, "<leader>go", "<Cmd>GBrowse<cr>") -- g(it) o(open) - Open file in the browser 
    end
}

