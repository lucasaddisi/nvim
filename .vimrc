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

noremap <leader>y "+y
" noremap <leader>p "+p
" Copy and paste the line, and increase by 1 all the digits in that line

noremap <leader>in Vyp:s/\d\+/\=submatch(0)+1/g<CR>  

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
xnoremap <leader>p "_dP
noremap <leader>d "_d
vnoremap <leader>d "_d

noremap <leader>pv :E<CR>

