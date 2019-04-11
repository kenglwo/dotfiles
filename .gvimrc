syntax on
colorscheme hybrid

" set guifont=RictyDiminished_Discord_Regular_Nerd_Font_Complete_Windows_Compatible:h18
set guifont=Ricty_Diminished_Discord_Regular_for_Powerline:h18
set guifontwide=RictyDiminished_Discord_Regular_Nerd_Font_Complete_Windows_Compatible:h18


nnoremap <silent> <Space><S-b> :set guifont=Ricty_Diminished_Discord_Bold:h24<Enter>
nnoremap <silent> <Space>b :set guifont=Ricty_Diminished_Discord:h24<Enter>

set columns=151
set lines=37
autocmd GUIEnter * set transparency =30 

function! s:toggle_transparence()
    if &transparency == 30 
        set transparency=0
    else
        set transparency=30
    endif
endfunction

nnoremap <silent> <Space>ot :<C-u>call <SID>toggle_transparence()<CR>


set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

let g:airline_powerline_fonts = 1


autocmd Filetype nerdtree set conceallevel=3
autocmd Filetype nerdtree set concealcursor=nvic
autocmd FileType nerdtree setlocal nolist
" set updatetime=50
