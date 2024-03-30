return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {"lua", "vim", "vimdoc", "query", "java", "python", "markdown", "json", "bash"}
		})
	end
}

