require("laddisi.remap")

-- Get the path to the directory containing init.lua
local script_dir = vim.fn.stdpath('config')

-- Concatenate the path to .vimrc file
local vimrc_path = script_dir .. '/.vimrc'

-- Source the .vimrc file
vim.cmd('source ' .. vimrc_path)

-- Change colorscheme

vim.cmd("colorscheme desert")

-- Modify updatetime (See h: updatetime)
vim.opt.updatetime=1500

-- Highlight text on cursor hover
vim.api.nvim_set_hl(0, 'LspReferenceText', {reverse = true})
vim.api.nvim_set_hl(0, 'LspReferenceRead', {reverse = true})
vim.api.nvim_set_hl(0, 'LspReferenceWrite', {reverse = true})

-- Lazy VIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "laddisi.plugins",
	change_detection = {notofy = false}
})
