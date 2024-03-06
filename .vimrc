" Set number and relative number
set rnu
set nu

" Set the leader key to space
let mapleader = ","
 
noremap <leader>c "*y
noremap <leader>p "*p
" Copy and paste the line, and increase by 1 all the digits in that line
noremap <leader>in Vyp:s/\d\+/\=submatch(0)+1/g<CR>  

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt


