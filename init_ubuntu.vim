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
Plug 'fugalh/desert.vim'

" Status Line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim' "For Tmux

" Semantic Highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "For python
Plug 'octol/vim-cpp-enhanced-highlight' "For CPP

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


"_____Auto Completion_____"

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Python
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'


"Snippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"Include File
Plug 'Shougo/neoinclude.vim'

" SuperTab
Plug 'ervandew/supertab'


"__________________________________________________________________________________"


call plug#end()

" Force to vim to use newer regex version, fixing lag when using vim
    set re=1
    set noequalalways


" indent config 
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set smarttab

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

"general config
	set mouse=
	set history=1000
	set number
	set relativenumber
    set nohlsearch
    set mousehide
    set lazyredraw "Fixlag while scolling
    set noswapfile

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

" Path config, reducting startup time
    let g:python_host_prog="/usr/bin/python2"
    let g:python3_host_prog = '/usr/bin/python3'

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
    let g:ale_linters = {
                \ 'cpp' : ['g++'],
                \ 'python' : ['pylint'],
                \}
    "Using pylint3 to improve the performance of pylint
    "while waiting for the next release of pylint to fix the bug
    "with pandas
    let g:ale_python_pylint_executable = '/usr/bin/pylint3'
    let g:ale_python_pylint_use_global = 1
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '⚠'
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
	nnoremap <silent> <leader>o  :BTags<CR>
	nnoremap <silent> <leader>oo :Tags<CR>
	nnoremap <silent> <leader>?  :History/<CR>
	nnoremap <silent> <leader>m  :Marks<CR>
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
    call deoplete#custom#option('auto_complete_delay', 0)
    call deoplete#custom#option('min_length_pattern', 2)
    call deoplete#custom#option('sources', {
                \ '[]': ['around', 'file','buffer', 'neosnippet'],
                \ 'cpp' : ['around', 'file', 'buffer', 'neosnippet', 'file/include'],
                \ 'python': ['around','jedi',  'file', 'buffer', 'tag', 'neosnippet'],
                \})
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Jedi-vim
    let g:jedi#completions_enabled = 0  " Disable autocompletion (using deoplete instead)
    let g:jedi#documentation_command = "K"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#goto_command = "gd"
    let g:jedi#use_splits_not_buffers = "top"
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = 1
    let g:deoplete#sources#jedi#show_docstring = 1

" Super Tab
    let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

