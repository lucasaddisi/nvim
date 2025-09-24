return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local actions = require "telescope.actions"
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "^%.git/", "^node_modules/" },
                layout_strategy = 'vertical'
            },
            pickers = {
                buffers = {
                    mappings = {
                        i = { ["<c-d>"] = actions.delete_buffer + actions.move_to_top }
                    }
                }
            },
        })
        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')
        local get_dropdown_ops = { hidden = true, ignore = true, previewer = false, layout_config = { width = 0.8 } }

        -- Marks
        vim.keymap.set('n', '<leader>m', builtin.marks, {}) -- List marks

        -- WD
        vim.keymap.set('n', '<leader>fd', function()
            builtin.find_files(themes.get_dropdown(get_dropdown_ops))
        end, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})                 -- Find grep
        vim.keymap.set('n', '<leader>fob', builtin.buffers, {})                  -- Find open buffers
        vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {}) -- Find in buffer
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})                 -- Find help
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})                  -- Find old

        -- Git
        vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>fgh', builtin.git_bcommits, {}) -- Find git history
        vim.keymap.set('n', '<leader>ff', function()
            builtin.git_files(themes.get_dropdown(get_dropdown_ops))
        end, {})
        vim.keymap.set('n', '<leader>fgs', builtin.git_status, {})

        -- LSP
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {}) -- Find references
        vim.keymap.set('n', '<leader>fe', builtin.diagnostics, {})    -- Find errors
        vim.keymap.set('n', '<leader>fm', function()                  -- Find methods
            builtin.lsp_document_symbols({ symbols = { 'function', 'class', 'method' } })
        end
        , {})
    end
    -- TODO: Find files from project git root with fallback: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#find-files-from-project-git-root-with-fallback
}
