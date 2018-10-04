
call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'srcery-colors/srcery-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'fugalh/desert.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'edkolev/tmuxline.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

if has('nvim')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

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
    " set t_Co=256 "Use 256 Color
    set autoread "automatically load buffer
    set noshowmode
	filetype indent on
	filetype on
	filetype plugin on
	filetype plugin indent on
	syntax enable
	set termguicolors     " enable true colors support
	colorscheme srcery 

    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    if &term =~ '256color'
        set t_ut=
    endif


"general config
	set mouse=
	set history=1000
	set number
	set relativenumber
    set nohlsearch
    set mousehide
    set lazyredraw "Fixlag while scolling

    let g:deoplete#enable_at_startup = 1

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

"-------------------------------------------------------------------------------------------------
"-------------------------------------------------------------------------------------------------

"TagBar config
	nnoremap <F7> :TagbarToggle<CR>

"NerdTree config
	nnoremap <F6> :NERDTreeToggle<CR>
	let NERDTreeShowHidden=1 "not show dot files
	"close nerdtree when closing vim
	autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
    let g:ale_python_pylint_executable = '/usr/bin/pylint'
    let g:ale_python_pylint_use_globale = 1
    let g:ale_python_pylint_options = '--generated-members=cv2.\* '
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '-'

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
	nnoremap <silent> <leader>l  :BLines<CR>
	nnoremap <silent> <leader>ll :Lines<CR>
	nnoremap <silent> <leader>o  :BTags<CR>
	nnoremap <silent> <leader>oo :Tags<CR>
	nnoremap <silent> <leader>?  :History/<CR>
	nnoremap <silent> <leader>m  :Marks<CR>
	nnoremap <silent> <leader>/  :execute 'Ag ' . input('Ag/') <CR>
	nnoremap <silent> <leader>f  :call SearchWordWithAg()<CR>
	vnoremap <silent> <leader>f  :call SearchVisualSelectionWithAg()<CR>
	imap <C-x><C-f> <plug>(fzf-complete-file-ag)
	imap <C-x><C-l> <plug>(fzf-complete-line)
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

" Pymode settings
     let g:pymode = 1
     let g:pymode_trim_whitespaces = 1
     let g:pymode_python = 'python3'
     let g:pymode_run = 1
     let g:pymode_run_bind = '<leader>r'
     let g:pymode_lint = 0
     let g:pymode_doc = 0
     let g:pymode_breakpoint = 0
     let g:pymode_indent = 1
     let g:python_host_prog="/usr/bin/python2"
     let g:python3_host_prog = '/usr/bin/python3'
     let g:pymode_rope_goto_definition_bind = 'gd'
     let g:pymode_rope_completion = 0
     let g:pymode_rope_complete_on_dot = 0
     let g:pymode_syntax=1
     let g:pymode_syntax_all=1
