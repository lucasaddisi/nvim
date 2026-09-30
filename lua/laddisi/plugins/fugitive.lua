return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb"
    },
    init = function()
        vim.g.github_enterprise_urls = { "https://git.soma.salesforce.com" }
    end,
    config = function()
        vim.keymap.set({'n', 'v'}, "<leader>gb", "<Cmd>Git blame<CR>")
        vim.keymap.set({'n', 'v'}, "<leader>gd", "<Cmd>Gvdiffsplit<CR>") -- Opens vimdiff. dp (diffput) do (diffobtain)
        vim.keymap.set('n', "<leader>go", "<Cmd>GBrowse<cr>") -- g(it) o(open) - Open file in the browser
        vim.keymap.set('v', "<leader>go", ":GBrowse<cr>") -- ':' passes the '<,'> range so the selected lines are highlighted
        vim.keymap.set({'n', 'v'}, "<leader>gs", "<Cmd>Git<cr>") -- g(it) s(status) - Open fugitive interactive prompt
    end
}

