" Set number and relative number
set rnu
set nu

" Set the leader key to space
let mapleader = " "
 
set scrolloff=10

" Set indent 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

nnoremap <C-d> <C-d>zz

noremap <leader>y "+y
" Yank current buffer path in the clipboard
noremap <leader>py :let @+ = expand('%:p')<CR>

" Change tabs easily
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Move line while visual mode
vnoremap <expr> J ":m '>+1<CR>gv=gv"
vnoremap <expr> <S-Down> ":m '>+1<CR>gv=gv"
vnoremap <expr> K ":m '<-2<CR>gv=gv"
vnoremap <expr> <S-Up> ":m '<-2<CR>gv=gv"

" Delete but do not lose the content in buffer
noremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap p "_dP

