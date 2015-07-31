set noswapfile
set autoindent
"set number
set expandtab
set tabstop=4
set colorcolumn=80
highlight ColorColumn ctermbg=black
highlight ExtraWhitespace ctermbg=red guibg=red
highlight Tab ctermbg=red
match ExtraWhitespace /\s+$/
match Tab /\t/

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
