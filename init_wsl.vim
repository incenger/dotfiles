call plug#begin('~/.local/share/nvim/plugged')

"_____Systax checking_____"
Plug 'w0rp/ale'
"__________________________________________________________________________________"


"_____Language Support Package_____"
Plug 'sheerun/vim-polyglot'
"__________________________________________________________________________________"


"_____Moving around the text_____"
Plug 'easymotion/vim-easymotion'
"__________________________________________________________________________________"


"_____Undotree_____"
Plug 'mbbill/undotree'
"__________________________________________________________________________________"


"_____Pairing_____"
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
"__________________________________________________________________________________"


"_____Comment_____"
Plug 'tpope/vim-commentary'
"__________________________________________________________________________________"


"_____Tag______"
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
"__________________________________________________________________________________"


"_____Tmux_____"
Plug 'christoomey/vim-tmux-navigator'
"__________________________________________________________________________________"


"_____File tree_____"
Plug 'scrooloose/nerdtree'
"Icons for filetype of NerdTree
Plug 'ryanoasis/vim-devicons' 
"Highlighting filetype in NerdTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
"__________________________________________________________________________________"



"_____Syntax Highlighting and Theme, Indent..., anything makes VIM looking better_____"

" Theme 
Plug 'srcery-colors/srcery-vim'

" Status Line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim' "For Tmux

" Semantic Highlighting
Plug 'numirias/semshi', {'for':'python', 'do': ':UpdateRemotePlugins'} "For python
Plug 'octol/vim-cpp-enhanced-highlight', {'for' : 'cpp'} "For CPP

" Indentation
Plug 'yggdroot/indentline'
"__________________________________________________________________________________"

"_____Searching_____"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
"__________________________________________________________________________________"

"_____Copy and Paste_____"
Plug 'junegunn/vim-peekaboo'
"__________________________________________________________________________________"

"_____Unix Command______"
Plug 'tpope/vim-eunuch'

"__________________________________________________________________________________"

"_____Auto Completion_____"

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Python
" Plug 'zchee/deoplete-jedi', {'for' : 'python'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }


"Snippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"Include File
Plug 'Shougo/neoinclude.vim'

" Show function signature
Plug 'Shougo/echodoc.vim'
"__________________________________________________________________________________"

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

    set noequalalways


" indent config 
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab

"movement config
    nnoremap j gj
    nnoremap k gk
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

"UI config
    set autoread "automatically load buffer
    set noshowmode
	filetype indent on
	filetype on
	filetype plugin on
	filetype plugin indent on
	syntax enable
	set termguicolors     " enable true colors support
    colorscheme srcery 
    set background=dark

"general config
	set mouse=a
	set history=1000
	set number
	set relativenumber
    set nohlsearch
    set mousehide
    set lazyredraw "Fixlag while scolling
    set noswapfile
    set cursorline " Highlight current line

"searching config
	set ignorecase
	set smartcase

"folding config
	set foldenable
	set foldmethod=indent
	set foldlevelstart=4
	set foldnestmax=10

"general mapping
	nnoremap <space> <nop> 
	let mapleader = "\<space>" 
	let maplocalleader = "\\" 
	nnoremap ; :
	inoremap jk <esc>
	inoremap kj <esc>
    "Copy content of the whole file
    nnoremap <leader>ya gg"+yG
    " use tab to forward cycle
    inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    " use s-tab to backward cycle
    inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

"-------------------------------------------------------------------------------------------------
"-------------------------------------------------------------------------------------------------

"TagBar config
	nnoremap <F7> :TagbarToggle<CR>

"NerdTree config
	nnoremap <F6> :NERDTreeToggle<CR>
	let NERDTreeShowHidden=1 "not show dot files
	"close nerdtree when closing vim
	autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1

"Undo Tree
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
    
"EasyMotion Config
	nmap <leader>s <Plug>(easymotion-prefix)s

"Ale Config
    let g:ale_lint_on_text_changed = 'never'
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

    nmap <silent> <leader>k <Plug>(ale_previous_wrap)
    nmap <silent> <leader>j <Plug>(ale_next_wrap)

" snippet config 
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

" change comment style
     autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" Fzf {{{
    " Fzf settings
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
	nnoremap <silent> <leader>c  :Commands<CR>
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
"}}}


" cpp-enhanced-highlight settings
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_experimental_template_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_class_decl_highlight = 1

" Deoplete 
    let g:deoplete#enable_at_startup = 1
    if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
    endif
    call deoplete#custom#option('auto_complete_delay', 0)
    call deoplete#custom#option('min_pattern_length', 2)
    call deoplete#custom#option('sources', {
                \ '[]': ['around', 'buffer', 'neosnippet'],
                \ 'cpp' : ['around', 'file', 'buffer', 'tag', 'neosnippet'],
                \ 'python': ['around', 'file', 'buffer', 'LanguageClient','tag', 'neosnippet'],
                \})
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" EchoDoc
	let g:echodoc_enable_at_startup = 1

" LanguageClient
    " Required for operations modifying multiple buffers like rename.
    set hidden
    let g:LanguageClient_settingsPath = "~/.config/nvim/settings.json"
    let g:LanguageClient_diagnosticsEnable=0
    let g:LanguageClient_loadSettings = 1
    let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
        \ 'python3': ['pyls', '--log-file=/tmp/pyls3.log'],
        \ }
    nnoremap <F10> :call LanguageClient_contextMenu()<CR>
    autocmd FileType python,python3 nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType python,python3 nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    autocmd FileType python,python3 nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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
    au BufNewFile,BufRead *.py set filetype=python
    autocmd BufNewFile,BufRead *.py
                \ set tabstop=4 |
                \ set softtabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |
                \ set fileformat=unix

" lightline {{{
    let g:lightline = {
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

"Semshi
    let g:semshi#error_sign=v:false
    " let g:semshi#active=v:false
