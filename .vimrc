"" " 
" On Vim for all, latex, email, ide, todo
""""
"
"Inicio Vundel
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"shows the space indents based on the feature conceal
Plugin 'Yggdroot/indentLine'
"removing the whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" gc will comment out a block or line of code in any language ... almost
Plugin 'tpope/vim-commentary'
" <space>+u for a undo tree
Plugin 'sjl/gundo.vim'
"Search engine with repgrep FZF"
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
"Snippets with supertab for YCM compatibility
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
"Themes
Plugin 'w0ng/vim-hybrid'
Plugin 'kristijanhusak/vim-hybrid-material'
"Folding magic
Plugin 'tmhedberg/SimpylFold'
"Never leave vim
Plugin 'tpope/vim-fugitive'
"NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
"Airline Shizzle
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Tags easy
Plugin 'ludovicchabant/vim-gutentags'
"Checking Pyhton Syntax
Plugin 'scrooloose/syntastic'
Plugin 'Vimjas/vim-python-pep8-indent'
" Le Colorization
Plugin 'sheerun/vim-polyglot'
"Latex, one vim for all
Plugin 'lervag/vimtex'
"Snippets by ultisnipets
"Icons
Plugin 'ryanoasis/vim-devicons'
Plugin 'chrisbra/Colorizer'
" todotxt
Plugin 'freitass/todo.txt-vim'
" VHDL
" Plugin 'suoto/vim-hdl'
" Graphviz
Plugin 'liuchengxu/graphviz.vim'
" Tmux Stuff
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
""" Termino Vundel

"Usabilidad
filetype plugin indent on "carga segun tipo de archivo de ~/.vim/indent/python.vim
set wildmenu "Muestra las posbilidad al TAB
set lazyredraw "No refresca inecesariamente durante comandos largos
set showmatch "Resalta el par de [{()}]
set gdefault "Add the g flag to search/replace by default
set binary "dont add empty newlines at the end of files
set noeol "dont add empty newlines at the end of files
set colorcolumn=79

"nmap <SPACE> <leader>
let mapleader="\<space>" "leader es space

"Very Usfull
"Save, Clear the view, Compile with name of file without dots, and Execute
nnoremap <silent> <F7> :w<CR>:!clear;gcc % -o %< && ./%<<CR>
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!ipython' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!ipython' shellescape(@%, 1)<CR>
"Avoid sudo problem
command W :execute ':silent w !sudo tee % > /dev/null' | :edit! "Saving without sudo

"Buffer
"Para abrir un nuevo buffer
nmap <leader>t :enew<CR>
"moverse al siguiente buffer
nmap <leader>l :bnext<CR>
"moverse al buffer anterior
nmap <leader>h :bprevious<CR>
"cerrar buffer
nmap <leader>bq :bp <BAR> bd #<CR>

" Highlightening
let python_highlight_all=1
syntax on

"" Spelling
:command Spellus setlocal spell spelllang=en_us
:command Spellde setlocal spell spelllang=de

"ColorScheme
if has('gui_running')
  set background=light
  colorscheme hybrid
else
  set background=dark
  " let g:hybrid_custom_term_colors = 1
  let g:enable_italic_font = 1
  " let g:hybrid_transparent_background = 1
  let g:hybrid_reduced_contrast = 1
  colorscheme hybrid_material
  let g:airline_theme = "hybrid"
endif

"Fonts
set guifont=InconsolataGo\ Nerd\ Font\ Mono\ 14
set encoding=utf-8
set fileencoding=utf-8

"Loading Glyphs
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline = 1

"IdentLine
let g:indentLine_char = '│'

"Spaces and Tabs
set tabstop=4 "numero de espacios visuales por TAB
set softtabstop=0 "numero de espacios que general al TAB
set expandtab "Transforma los TAB's en esapcios
set shiftwidth=4 "used by things like <> =
set smarttab
"File specific
augroup FileTypeSpecificAutocommands
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
"UI Config
set backspace=indent,eol,start
set number relativenumber "mostrar numero de linea
set showcmd "mostrar ultimo comando usado en vim
set cursorline "resalta la linea del cursor
set laststatus=2 "Allways show the status bar
set ruler "Show ruling paramerterin in status line
set showmode "If Visual Mode is on its shown in the line
"set shortmess=atI "Don't show intro message when starting vim
set scrolloff=8 "Start scrolling 3 lines before end of file
set hidden "Permite a los bufferes desaparecer si se han modificado
"set guiheadroom=0 " Empty Space at the bottom of gVim
set fileformats=dos

""Python with virtualenv support ... Not needed with pipenv
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  with open(activate_this) as f:
"    exec(f.read(), {'__file__': activate_this})
"EOF

"" Search stuff
set incsearch "busca por cada caracter insertado
set hlsearch "resalta lo encontrado
"dejar de resaltar con Enter ... <silent> evita echo en cmd
nnoremap <silent> <CR> :nohl<CR><CR>

"Movimientos Verticales segun linea visual
nnoremap j gj
nnoremap k gk
"destaca ultimo texto insertado
"nnoremap gV `[v`]

"Split Navigations Control + hjkl mueve entre buffers
" FIXME: In conflict with the vim-tmux plugin
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

"toggle para el disparador grafico de undo
noremap <leader>u :GundoToggle<CR>

"Esto guarda la session completa que luego se abre con vim -S
nnoremap <leader>s :mksession!<CR>

"Guarda en un lugar especifico los swaps backups y undo
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo

"Folding
set foldenable
set foldlevelstart=10  "Deja la mayoria de los folds abiertos
set foldnestmax=10 "No permite mas de 10 nidos
nnoremap <silent> , za
set foldmethod=indent "Deja el fold basado en indent ... .vim/indent/pyhton.vim
"See docstring for folden code
let g:SimpylFold_docstring_preview=1

"NERDTree sin gylphos y shortcut
nnoremap <silent><leader>f :NERDTree<CR>
nnoremap <silent><leader>c :NERDTreeClose<CR>
nnoremap <silent><leader>v :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeDirArrows = 1
let g:NERDTreeGitStatusIndicatorCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Rp for grep
if executable('rg')
    " Use ag over grep
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

let g:fzf_action = {
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

" Rg only searching in files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
  \   1,
  \   {'options': $FZF_DEFAULT_OPTS . " --delimiter=':'" . " --nth='4..'" }, <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': $FZF_DEFAULT_OPTS}, <bang>0)

nnoremap <c-p> :Files<CR>
nnoremap <leader>p :Rg <CR>

"VimText
let g:tex_flavor = 'latex'

"AirLine
"Activar lista de buffers en Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_splits = 0
"Muestra solo el nombre del archivo
let g:airline#extensions#tabline#fnamemod = 1
let g:airline_powerline_fonts = 1
"Syntasticline ?
let g:airline#extenssion#syntastic#enable = 1

"Syntastic auto Airline
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_html_tidy_exec = '/usr/bin/tidy'
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1

"AutoComplete
let g:ycm_global_ycm_extra_conf = '/home/adux/.vim/bundle/vim-snippets/autoload/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter = '/usr/bin/python3'
"Youcompleteme con vimtex
if !exists('g:ycm_semantic_triggers')
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
"Va a la definicion seleccionada
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" From Django Recomendations
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" Here YouCompleteMe is bound to a different combination Ctrl + n,
" but then that combination is bound to tab through SuperTab.
" UltiSnips and SuperTab play nice together, so you can then just bind
" UltiSnips to tab directly and everything will work out.
" http://stackoverflow.com/a/22253548/1626737
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" UltiSnips Config
let g:UltiSnipsListSnippets = "<C-s>" "List possible snippets based on current file

" Tags :D
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
" Tags generated imediatly
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

"Paste Trick
"https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim/38258720#38258720
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"Gundo improve
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

" Auto load
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
set autoread
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None