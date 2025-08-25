return {
    'Exafunction/windsurf.vim',
    config = function()
        -- More info in https://github.com/Exafunction/windsurf.vim/blob/main/README.md
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
}
