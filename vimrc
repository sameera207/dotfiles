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

Plugin 'nanotech/jellybeans.vim'
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
Plugin 'https://github.com/honza/vim-snippets'
Plugin 'kana/vim-arpeggio'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-commentary.git'
Plugin 'ervandew/supertab'
Plugin 'jreybert/vimagit'
Plugin 'https://github.com/AndrewRadev/splitjoin.vim'
Plugin 'gregsexton/gitv'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'mattn/emmet-vim'
Plugin 'https://github.com/adelarsq/vim-matchit'
Plugin 'https://github.com/majutsushi/tagbar'
Plugin 'https://github.com/godlygeek/tabular'
Plugin 'brooth/far.vim'
Plugin 'ngmy/vim-rubocop'


" inline search highlight / working with easy motion
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'

" typescript
Plugin 'https://github.com/Quramy/tsuquyomi'
Plugin 'https://github.com/jason0x43/vim-js-indent'
Plugin 'https://github.com/leafgarland/typescript-vim'
Plugin 'Quramy/vim-js-pretty-template'




call vundle#end()


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep ='|'
let g:airline#extensions#tabline#formatter ='default'

" enable indent guide
" https://github.com/nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" configs
syntax on
filetype plugin indent on
set number
set hidden
set tags=tags
set relativenumber!
set t_Co=256

set background=dark
colorscheme jellybeans

" let g:airline_theme='base16'


" set showmode

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" key mappings
let mapleader = ","


" vim-multiple-cursors
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'




let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ctrlp_map = '<leader>f'
nnoremap <leader>. :CtrlPTag<cr>


" Indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set showtabline=2



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
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

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

map <leader>r :call RenameFile()<cr>

" incsearch-easymotion
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" end of incsearch-easymotion

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
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" use system clipboard as the default
" https://github.com/tmux/tmux/issues/543#issuecomment-248980734
" https://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
if $TMUX == ''
  set clipboard=unnamed
endif

" copy and paste
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
" vim-rspec mappings
map <Leader>p :call RunCurrentSpecFile()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" ===== Seeing Is Believing =====
" Assumes you have a Ruby with SiB available in the PATH
" If it doesn't work, you may need to `gem install seeing_is_believing`

function! WithoutChangingCursor(fn)
  let cursor_pos     = getpos('.')
  let wintop_pos     = getpos('w0')
  let old_lazyredraw = &lazyredraw
  let old_scrolloff  = &scrolloff
  set lazyredraw

  call a:fn()

  call setpos('.', wintop_pos)
  call setpos('.', cursor_pos)
  redraw
  let &lazyredraw = old_lazyredraw
  let scrolloff   = old_scrolloff
endfun

function! SibAnnotateAll(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibAnnotateMarked(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --xmpfilter-style --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibCleanAnnotations(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --clean"]))
endfun

function! SibToggleMark()
  let pos  = getpos('.')
  let line = getline(".")
  if line =~ '^\s*$'
    let line = '# => '
  elseif line =~ '# =>'
    let line = substitute(line, ' *# =>.*', '', '')
  else
    let line .= '  # => '
  end
  call setline('.', line)
  call setpos('.', pos)
endfun


" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :move  '<-2<CR>gv=gv
xnoremap <silent> J :move  '>+1<CR>gv=gv


