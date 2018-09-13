
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
Plug 'roosta/srcery'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'fugalh/desert.vim'
Plug 'itchyny/lightline.vim'
 

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

" indent config 
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set expandtab
	set number

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
    " set Vim-specific sequences for RGB colors
    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors     " enable true colors support
    " set background=dark
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
    " if !exists('g:undotree_SplitWidth')
    "     if g:undotree_ShortIndicators == 1
    "         let g:undotree_SplitWidth = 24
    "     else
    "         let g:undotree_SplitWidth = 30
    "     endif
    " endif

"EasyMotion Config
	nmap <leader>s <Plug>(easymotion-prefix)s

"Ale Config
    let g:ale_lint_on_text_changed = 'never'

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
