call plug#begin()

" Colorscheme
Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'gabesoft/vim-ags'

" find and replace
Plug 'brooth/far.vim'
Plug 'scrooloose/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/nerdcommenter'
Plug 'kana/vim-arpeggio'
Plug 'tpope/vim-bundler'
Plug 'adelarsq/vim-matchit'

Plug 'mattn/emmet-vim'

Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-ruby'
Plug 'sbdchd/neoformat'


" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'
Plug 'othree/html5.vim'
Plug 'Shougo/echodoc.vim'

" snippets
" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets'
" React code snippets
Plug 'sameera207/vim-react-snippets'
Plug 'honza/vim-snippets' " Ultisnips
Plug 'SirVer/ultisnips'

Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" rspec runner
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'

call plug#end()

syntax on
filetype plugin indent on
set number
set hidden
set tags=tags
set relativenumber!
set encoding=utf8

" Improving scrolling performance for far
set lazyredraw
set regexpengine=1

set hidden

if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1

"colorscheme gruvbox
"set background=light

let mapleader = ","

call arpeggio#map('i', '', 0, 'jk', '<Esc>')

map z/  <Plug>(incsearch-forward)
map z/?  <Plug>(incsearch-backward)
map zg/ <Plug>(incsearch-stay)
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)

let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'

" search 
" navigate file paths forward
" P    - navigate files paths backwards
" r    - navigate results forward
" R    - navigate results backwards
" a    - display the file path for current results
" c    - copy to clipboard the file path for current results
" E    - enter edit mode
" oa   - open file above the results window
" ob   - open file below the results window
" ol   - open file to the left of the results window
" or   - open file to the right of the results window
" os   - open file in the results window
" ou   - open file in a previously opened window
" xu   - open file in a previously opened window and close the search results
" <CR> - open file in a previously opened window
" q    - close the search results window
" u    - displays these key mappingsap <leader>s :Ag! <space>

let g:ags_agexe = 'rg'
let g:ags_agargs = {
  \ '--column'         : ['', ''],
  \ '--line-number'    : ['', ''],
  \ '--context'        : ['g:ags_agcontext', '-C'],
  \ '--max-count'      : ['g:ags_agmaxcount', ''],
  \ '--heading'        : ['',''],
  \ '--smart-case'     : ['','-S'],
  \ '--color'          : ['always',''],
  \ '--colors'         : [['match:fg:green', 'match:bg:black', 'match:style:nobold', 'path:fg:red', 'path:style:bold', 'line:fg:black', 'line:style:bold'] ,''],
  \ }
" Search for the word under cursor
nnoremap <Leader>d :Ags<Space><C-R>=expand('<cword>')<CR><CR>
" Search for the visually selected text
vnoremap <Leader>a y:Ags<Space><C-R>='"' . escape(@", '"*?()[]{}.') . '"'<CR><CR>
" Run Ags
nnoremap <Leader>s :Ags<Space>
" Quit Ags
nnoremap <Leader><Leader>s :AgsQuit<CR>

map <leader>t :NERDTreeToggle<cr>
nnoremap <leader>b :BufExplorer<cr>
nnoremap <leader>m <c-^>

" ultisnips
let g:UltiSnipsExpandTrigger="<C-l>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" run a formatter on save
"augroup fmt
  "autocmd!
  "autocmd BufWritePre * undojoin | Neoformat
"augroup END
map <leader>p :Neoformat

" emmet mapping
" <C-x>
let g:user_emmet_leader_key='<C-z>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

"====================================
" dash
" ===================================
nmap <Leader>k :Dash<cr>

" ===================================
" coc.nvim
" ===================================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" end of coc.vim
" ===================================
let g:echodoc#enable_at_startup = 1

set clipboard=unnamed

" ====================================
" Snippet expand keys 
" ctrl-j
" ====================================

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" end of snnippet key bindings
" ====================================

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

autocmd FileType json syntax match Comment +\/\/.\+$+

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :move  '<-2<CR>gv=gv
xnoremap <silent> J :move  '>+1<CR>gv=gv

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


" ====================================
" RSpec
" Go to spec (rails)
map <leader>l :A<cr>

" janko/vim-test
let test#ruby#rspec#options = {
  \ 'nearest': '--backtrace',
  \ 'file':    '--format documentation',
  \ 'suite':   '--tag ~slow',
  \}
let test#neovim#term_position = "topleft"
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'basic',
  \}
let g:test#preserve_screen = 0
" end of RSpec config
" ====================================


