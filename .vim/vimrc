set noswapfile
set autoindent
"set number
set expandtab
set tabstop=4
set colorcolumn=80
set ruler
" Make backspace behave like other editors
set backspace=2
" Disable .viminfo file
set viminfo=

syntax on
highlight ColorColumn ctermbg=black
highlight ExtraWhitespace ctermbg=red guibg=red
highlight Tab ctermbg=red
match ExtraWhitespace /\s+$/
match Tab /\t/

" vimdiff highlighting
highlight DiffAdd    cterm=bold ctermbg=22
highlight DiffDelete cterm=bold ctermbg=88
highlight DiffChange            ctermbg=17
highlight DiffText   cterm=bold ctermbg=12

" Set nosetests alias
command Nose ! nosetests
abbrev nose Nose

execute pathogen#infect()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
