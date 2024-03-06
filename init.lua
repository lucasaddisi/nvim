require("kickstart")

-- Get the path to the directory containing init.lua
local script_dir = vim.fn.stdpath('config')

-- Concatenate the path to .vimrc file
local vimrc_path = script_dir .. '/.vimrc'

-- Source the .vimrc file
vim.cmd('source ' .. vimrc_path)
