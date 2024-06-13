" I'm not sure this is the most organized way to load files syntax
" highligtning, but is the best I can do so far. Please, refere to
" new-filetype in the manual reference to get a better idea on what to do

" Detect antlr4 files
au BufRead,BufNewFile *.g4 set filetype=antlr4

