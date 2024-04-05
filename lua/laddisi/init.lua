-- Get the path to the directory containing init.lua
local script_dir = vim.fn.stdpath('config')

-- Concatenate the path to .vimrc file
local vimrc_path = script_dir .. '/.vimrc'

-- Source the .vimrc file
vim.cmd('source ' .. vimrc_path)

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

