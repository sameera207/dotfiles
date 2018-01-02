set nocompatible " be iMproved, required
filetype off     " required
filetype plugin indent on
" set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin()

set backspace=2



" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

call vundle#begin()

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-endwise'
Plugin 'rizzatti/dash.vim'
Plugin 'tpope/vim-rails'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-ruby/vim-ruby'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'jiangmiao/auto-pairs'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kana/vim-arpeggio'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-commentary.git'
Plugin 'ervandew/supertab'


call vundle#end()


" configs
syntax on
filetype plugin indent on
set number
set hidden
set tags=tags

set showmode

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:ctrlp_map = '<leader>f'


" Indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set showtabline=2


" key mappings
let mapleader = ","

" ag/silver searcher
" search for the word under the cursor
map <leader>d :Ag! <cword><CR>

" search any given string
map <leader>s :Ag! <space>

" remap ESC key
call arpeggio#map('i', '', 0, 'jk', '<Esc>')

map <leader>t :NERDTreeToggle<cr>
nmap <Leader>k :Dash<cr>
nnoremap <leader>b :BufExplorer<cr>
nnoremap <leader>m <c-^>

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" RENAME CURRENT FILE
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <leader>n :call RenameFile()<cr>

" Go to spec (rails)
map <leader>l :A<cr>

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Automatically clean up trailing whitespaces for certain filetypes
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre *.rb :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.erb :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.haml :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.sass :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.textile :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.js :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.html :call <SID>StripTrailingWhitespaces()

nnoremap <leader>b :BufExplorer<cr>

" use system clipboard as the default
" https://github.com/tmux/tmux/issues/543#issuecomment-248980734
" https://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
if $TMUX == ''
  set clipboard=unnamed
endif

" copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

