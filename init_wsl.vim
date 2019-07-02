

"________________________________________________________________________________________________________________"
"
"         .----------------.  .----------------.  .----------------.  .----------------.  .----------------.
"        | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
"        | | ____   ____  | || |     _____    | || | ____    ____ | || |  _______     | || |     ______   | |
"        | ||_  _| |_  _| | || |    |_   _|   | || ||_   \  /   _|| || | |_   __ \    | || |   .' ___  |  | |
"        | |  \ \   / /   | || |      | |     | || |  |   \/   |  | || |   | |__) |   | || |  / .'   \_|  | |
"        | |   \ \ / /    | || |      | |     | || |  | |\  /| |  | || |   |  __ /    | || |  | |         | |
"        | |    \ ' /     | || |     _| |_    | || | _| |_\/_| |_ | || |  _| |  \ \_  | || |  \ `.___.'\  | |
"        | |     \_/      | || |    |_____|   | || ||_____||_____|| || | |____| |___| | || |   `._____.'  | |
"        | |              | || |              | || |              | || |              | || |              | |
"        | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
"         '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
"
"
"
"
"         |  _ \            |_   _|          / ____|
"         | |_) |  _   _      | |    _ __   | |        ___   _ __     __ _    ___   _ __
"         |  _ <  | | | |     | |   | '_ \  | |       / _ \ | '_ \   / _` |  / _ \ | '__|
"         | |_) | | |_| |    _| |_  | | | | | |____  |  __/ | | | | | (_| | |  __/ | |
"         |____/   \__, |   |_____| |_| |_|  \_____|  \___| |_| |_|  \__, |  \___| |_|
"                   __/ |                                             __/ |
"                  |___/                                             |___/
"
"
"                                   AND OTHER'S DOTFILES
"
"
"________________________________________________________________________________________________________________"


call plug#begin('~/.local/share/nvim/plugged')

"______________________________LANGUAGE PACKAGES___________________________________"

""" Linters
" Plug 'w0rp/ale'

""" Language Support
Plug 'sheerun/vim-polyglot'

""" Coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jsfaint/coc-neoinclude'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

""" Snippet
Plug 'https://github.com/honza/vim-snippets'

""" Inclue Path
Plug 'Shougo/neoinclude.vim'

""" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

""" Function Signature in StatusLine
Plug 'Shougo/echodoc.vim'

""" Semantic Highlighting
Plug 'numirias/semshi', {'for':'python', 'do': ':UpdateRemotePlugins'} "For Python
Plug 'octol/vim-cpp-enhanced-highlight', {'for' : 'cpp'} "For CPP


"__________________________________________________________________________________"




"_________________________________GENERAL__________________________________________"

""" Quickly Moving Around Text
Plug 'easymotion/vim-easymotion'

""" History Tree of File
Plug 'mbbill/undotree'

""" Pairing
Plug 'jiangmiao/auto-pairs'

""" Bracket surrounding text
Plug 'tpope/vim-surround'

""" Commenting
Plug 'tpope/vim-commentary'

""" Generate and Manage Tags
Plug 'liuchengxu/vista.vim'
" Plug 'majutsushi/tagbar'
" Plug 'ludovicchabant/vim-gutentags'

""" Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

""" Folder Tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

""" Indentation
Plug 'yggdroot/indentline'

""" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

""" Register Manager
Plug 'junegunn/vim-peekaboo'

""" Executing Unix Command
Plug 'tpope/vim-eunuch'

"__________________________________________________________________________________"




"____________________________________UI____________________________________________"
""" Theme
Plug 'srcery-colors/srcery-vim'

""" Status Line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim' "For Tmux
"__________________________________________________________________________________"
call plug#end()


"____________________________________GENERAL CONFIG________________________________"

""" Indentation
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set smarttab

""" UI
    set termguicolors
    colorscheme srcery
	set mouse=a
	set number
	set relativenumber
    set mousehide
    set lazyredraw "Fixlag while scolling
    set cursorline " Highlight current line
    set guicursor=

""" Content
	set history=1000
    set noswapfile
    set autoread "automatically load buffer
    set noshowmode
    set encoding=utf-8

""" Filetype
	filetype indent on
	filetype on
	filetype plugin indent on
	syntax enable

    """ Python
    autocmd BufNewFile,BufRead *.py set filetype=python
    autocmd BufNewFile,BufRead *.py
                \ set tabstop=4 |
                \ set softtabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |
                \ set fileformat=unix

""" Searching
    set incsearch
    set nohlsearch
	set ignorecase
	set smartcase
    set inccommand=split

""" Folding
	set foldenable
	set foldmethod=indent
	set foldlevelstart=3
	set foldnestmax=10


""" Windows
    set noequalalways
    set hidden

"-------------------------------------------------------------------------------------------------"



"---------------------------------------MAPPING---------------------------------------------------"

""" Movement
    nnoremap j gj
    nnoremap k gk
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>


""" General
	nnoremap <space> <nop>
	let mapleader = "\<space>"
	let maplocalleader = "\\"
	nnoremap ; :
	inoremap jk <esc>
	inoremap kj <esc>
    "Copy content of the whole file
    nnoremap <leader>ya gg"+yG
    " use tab to forward cycle
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " use s-tab to backward cycle
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " Remove whitespace
    nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

"-------------------------------------------------------------------------------------------------"





"--------------------------------------PLUGIN CONFIG----------------------------------------------"
""" Vista
	nnoremap <F7> :Vista!!<CR>
    let g:vista#renderer#enable_icon = 1

""" NerdTree config
	nnoremap <F6> :NERDTreeToggle<CR>
	let NERDTreeShowHidden=1 "not show dot files
	"close nerdtree when closing vim
	autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1

""" Undo Tree
    nnoremap <F5> :UndotreeToggle<cr>
    " let g:undotree_SetFocusWhenToggle=1
    if has("persistent_undo")
        set undodir=~/.undodir/
        set undofile
    endif
    if !exists('g:undotree_WindowLayout')
        let g:undotree_WindowLayout = 2
    endif

    if !exists('g:undotree_SetFocusWhenToggle')
        let g:undotree_SetFocusWhenToggle = 1
    endif

""" EasyMotion
	nmap <leader>s <Plug>(easymotion-prefix)s

""" ALE
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_echo_msg_format ='[%linter%] %s [%severity%]'
    let g:ale_linters_explicit = 1
    let g:ale_linters = {
                \ 'cpp' : ['g++'],
                \ 'python' : ['pyls'],
                \}
    let g:ale_python_pyls_config = {
        \ "pyls": {
            \ "plugins": {
            \    "pyflakes": {
            \       "enabled": v:true
            \   },
            \   "pydocstyle": {
            \       "enabled": v:false
            \   },
            \   "pycodestyle": {
            \       "enabled": v:true
            \   },
            \   "mccabe": {
            \       "enabled": v:false
            \   },
            \   "autopep8": {
            \       "enabled": v:false
            \   },
            \   "papf": {
            \       "enabled": v:false
            \   },
            \   "pylint": {
            \       "enabled": v:false
            \   }
            \}
        \}
    \}
    let g:ale_sign_error = ''
    let g:ale_sign_warning = ''
    highlight clear ALEErrorSign
    highlight clear ALEWarningSign

    " nmap <silent> <leader>k <Plug>(ale_previous_wrap)
    " nmap <silent> <leader>j <Plug>(ale_next_wrap)


""" Snippet
    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " xmap <C-k>     <Plug>(neosnippet_expand_target)

""" Comment
    autocmd FileType c,cpp,java setlocal commentstring=//\ %s

""" Fzf
    function! s:fzf_statusline()
        " Override statusline as you like
        " highlight fzf1 ctermfg=161 ctermbg=251
        " highlight fzf2 ctermfg=23 ctermbg=251
        " highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
    endfunction

	autocmd! User FzfStatusLine call <SID>fzf_statusline()
    nnoremap <silent> <C-p>      :GFiles<CR>
	nnoremap <silent> <leader>b  :Buffers<CR>
	nnoremap <silent> <leader>;  :History: <CR>
	nnoremap <silent> <leader>l  :Lines<CR>
	nnoremap <silent> <leader>o  :Tags<CR>
	nnoremap <silent> <leader>?  :History/<CR>
	nnoremap <silent> <leader>m  :Marks<CR>
	nnoremap <silent> <leader>p  :Commands<CR>
	nnoremap <silent> <leader>/  :execute 'Ag ' . input('Ag/') <CR>
	nnoremap <silent> <leader>f  :call SearchWordWithAg()<CR>
	vnoremap <silent> <leader>f  :call SearchVisualSelectionWithAg()<CR>
	imap <C-x><C-f> <plug>(fzf-complete-file-ag)
	imap <C-x><C-l> <plug>(fzf-complete-line)


    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }
	function! SearchWordWithAg()
		execute 'Ag' expand('<cword>')
	endfunction

	function! SearchVisualSelectionWithAg() range
		let old_reg = getreg('"')
		let old_regtype = getregtype('"')
		let old_clipboard = &clipboard
		set clipboard&
		normal! ""gvy
		let selection = getreg('"')
		call setreg('"', old_reg, old_regtype)
		let &clipboard = old_clipboard
		execute 'Ag' selection
	endfunction


""" Cpp-enhanced-highlight
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_experimental_template_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_class_decl_highlight = 1

""" Deoplete
    " if !exists('g:deoplete#omni#input_patterns')
    "   let g:deoplete#omni#input_patterns = {}
    " endif

    " let g:deoplete#enable_at_startup = 1
    " call deoplete#custom#option('auto_complete_delay', 0)
    " call deoplete#custom#option('min_pattern_length', 4)
    " call deoplete#custom#option('sources', {
    "             \ '[]': ['around', 'buffer', 'neosnippet'],
    "             \ 'cpp' : ['around', 'file', 'buffer', 'tag', 'neosnippet'],
    "             \ 'python': ['around', 'file', 'buffer', 'LanguageClient','tag', 'neosnippet'],
    "             \})
    " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" EchoDoc
	let g:echodoc_enable_at_startup = 1

" LanguageClient
    " Required for operations modifying multiple buffers like rename.
    " let g:LanguageClient_settingsPath = "~/.config/nvim/settings.json"
    " let g:LanguageClient_diagnosticsEnable=0
    " let g:LanguageClient_loadSettings = 1
    " let g:LanguageClient_serverCommands = {
    "     \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
    "     \ 'python3': ['pyls', '--log-file=/tmp/pyls3.log'],
    "     \ }
    " nnoremap <F10> :call LanguageClient_contextMenu()<CR>
    " autocmd FileType python,python3 nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " autocmd FileType python,python3 nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    " autocmd FileType python,python3 nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Pymode
    let g:pymode = 1
    let g:pymode_python = 'python3'
    let g:pymode_syntax_all = 1
    let g:pymode_run = 1
    let g:pymode_breakpoint = 0
    let g:pymode_rope = 0
    let g:pymode_lint = 0
    let g:pymode_doc = 0
    let g:pymode_virtualenv = 0
    let g:pymode_run_bind = '<F12>'
    let g:python_host_prog='/usr/bin/python'
    let g:python3_host_prog = '/usr/bin/python3'
    let g:pymode_rope_completion = 0
    let g:pymode_rope_complete_on_dot = 0

""" Lightline
       let g:lightline = {
                \'colorscheme': 'wombat',
                \ 'component_function': {
                \     'filetype':   'CustomLightlineFiletype',
                \     'fileformat': 'CustomLightlineFileformat',
                \   }
                \ }

    function! CustomLightlineFiletype()
        return winwidth(0) > 70 ?
                    \ (strlen(&filetype) ?
                    \ &filetype . ' ' . WebDevIconsGetFileTypeSymbol()
                    \ : 'no ft')
                    \ : ''
    endfunction

    function! CustomLightlineFileformat()
        return winwidth(0) > 70 ?
                    \ (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
    endfunction

    """ Semshi
    let g:semshi#error_sign=v:false
    let g:semshi#mark_selected_nodes=1
    """ Better-whitespace
    let g:strip_whitespace_on_save=1
    let g:strip_whitespace_confirm=0

    """ Coc-nvim
    let g:coc_snippet_next = '<TAB>'
    let g:coc_snippet_prev = '<S-TAB>'
    let g:coc_status_error_sign = '•'
    let g:coc_status_warning_sign = '•'
    set updatetime=200

    let g:coc_global_extensions =[
                \'coc-snippets',
                \'coc-json',
                \'coc-python',
                \'coc-highlight',
                \'coc-emoji']
    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Use <CR> tor confirm completion
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Highlight symbol under cursor on CursorHold
    " autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)


    " Close the preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " augroup MyAutoCmd
    "     autocmd!
    "     " Setup formatexpr specified filetype(s).
    "     " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    "     " Update signature help on jump placeholder
    " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " augroup end

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>cd  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>

    " Highlight symbol under cursor on CursorHold
    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <Tab>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<Tab>" :
                \ coc#refresh()

