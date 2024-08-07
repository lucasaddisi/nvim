return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"apex", "lua", "vim", "vimdoc", "query", "java", "python", "markdown", "markdown_inline", "json", "bash", "xml"},
            highlight = {
                enable = true,
                additiona_vim_regex_highlighting = false,
            },
        })
    end
}

