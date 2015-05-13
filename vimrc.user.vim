" **** General section ****

scriptencoding utf-8
filetype plugin indent on
syntax on
colorscheme Tomorrow-Night-Eighties

set noeb vb t_vb=

set encoding=utf-8
set shortmess+=I
set backspace=2
set hidden
set laststatus=2
set ruler
set t_Co=256
set number
set showmatch
set showcmd
set showmode
set splitbelow
set splitright
set nofoldenable
set nolist
set hlsearch
set ignorecase
set incsearch
set smartcase
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set mouse=a
set mousehide
set wildignore+=.git,.hg,.svn
set wildignore+=*.6
set wildignore+=*.pyc
set wildignore+=*.rbc
set wildignore+=*.swp

set directory=/tmp
set backupdir=/tmp

nohls

" **** General mappings ****

let mapleader = "\<Space>"

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

noremap <silent><leader>/ :nohlsearch<CR>
noremap! jk <Esc>
noremap! jj <Esc>
nnoremap Q <nop>

nmap <F8> :TagbarToggle<CR>
nmap <F9> :e $HOME/.vimrc.user.vim<CR>
nmap <F6> :so $HOME/.vimrc<CR>

nmap <leader>c :1,$d<CR>
nmap <leader>w :w<CR>
nmap <leader>W :W<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
nmap <leader>cd :cd %:h<CR>
nmap <leader>lcd :lcd %:h<CR>
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>l :CtrlPLine<CR>

nnoremap <silent> j gj
nnoremap <silent> k gk

" Command to write as root if we don't have permission
cmap w!! %!sudo tee > /dev/null %

" **** Autocommands ****
au BufWritePost .vimrc.user.vim so ~/.vimrc.user.vim
au BufWritePost .vimrc so ~/.vimrc

" Have <esc> leave cmdline-window
autocmd CmdwinEnter * nnoremap <buffer> <esc> :q<cr>

"remove trailing whitespace
au bufread,bufwrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Don't fold anything.
autocmd BufWinEnter * set foldlevel=999999

" **** Explorer section ****

let g:netrw_liststyle=3

" **** DelimitMate ****

let delimitMate_expand_cr = 1

" **** Neocomplete section ****

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
          \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
          \ neocomplete#close_popup() . '<CR>'
inoremap <expr> <BS> delimitMate#WithinEmptyPair() ?
          \ "\<C-R>=delimitMate#BS()\<CR>" :
          \ neocomplete#smart_close_popup() . '<BS>'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" **** Neosnippet section ****

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_jump_or_expand)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_jump_or_expand)"
  \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-go/gosnippets/snippets'

" **** Go section ****
au Filetype go nnoremap <leader>gd :vsp <cr>:exe "GoDef" <cr>
au Filetype go nnoremap <leader>go :exe "GoDoc" <cr>
au Filetype go nnoremap <leader>gr :exe "GoRun" <cr>
au Filetype go nnoremap <leader>gi :exe "GoImport" <cr>
au Filetype go nnoremap <leader>gt :exe "GoTest" <cr>
au Filetype go nnoremap <leader>ge :exe "GoErrCheck" <cr>

" **** Easy motion settings ****
let g:EasyMotion_leader_key = '<leader>'

" **** Syntastic settings ****
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline_powerline_fonts = 1

" **** Vim multiple cursors settings ****

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
endfunction

" CtrlP

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|target|dist|tmp)|(\.(swp|ico|git|svn|tmp))$'

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

let g:ctrlp_lazy_update = 350
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 10000

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
  let line = getline('.')
  let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
  exec "bd" bufid
  exec "norm \<F5>"
endfunc<D-j>

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
