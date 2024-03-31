return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
        	"nvim-lua/plenary.nvim"
    	},
	config = function()
		require('telescope').setup({
			defaults = {
				file_ignore_patterns = {"^%.git/", "^node_modules/"}
			}
		})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff',
				function()
					builtin.find_files({hidden=true, ignore=true})
				end,
				{})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	end
}
