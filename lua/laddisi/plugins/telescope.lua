return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "^%.git/", "^node_modules/" }
            }
        })
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')
        local get_dropdown_ops = {hidden=true, ignore=true, previewer=false, layout_config = {width=0.8}}

        -- WD
        vim.keymap.set('n', '<leader>fd', function()
            builtin.find_files(themes.get_dropdown(get_dropdown_ops))
        end, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})

        -- Git
        vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>ff', function()
            builtin.git_files(themes.get_dropdown(get_dropdown_ops))
        end, {})
        vim.keymap.set('n', '<leader>fgs', builtin.git_status, {})

    end
    -- TODO: Find files from project git root with fallback: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#find-files-from-project-git-root-with-fallback
}
