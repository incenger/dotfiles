call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'maralla/completor.vim'
Plug 'maralla/completor-neosnippet'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'roosta/srcery'

call plug#end()

" indent config 
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set number

" movements
    nnoremap j gj
    nnoremap k gk
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>


" general filetype settings 
" UI settings
    set t_Co=256 "Use 256 colors
    set term=xterm-256color
    set autoread "automatically load buffer
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
" general editor settings
    set history=1000
    set mouse=
    set number
    set relativenumber
    set lazyredraw
    "let &colorcolumn=80
    "highlight ColorColumn ctermbg=235 guibg=#2c2d27

"Powerline usage
    set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
    set laststatus=2

" Nerdtree config
    nnoremap <F6> :NERDTreeToggle<CR>
    let NERDTreeShowHidden=1 "not show dot files
    "close nerdtree when closing vim
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" TagBar config
    nnoremap <F7> :TagbarToggle<CR>

" searching 
    set ignorecase
    set smartcase

" folding
    set foldenable
    set foldmethod=indent
    set foldlevelstart=3
    set foldnestmax=10

" general mappings
    nnoremap <space> <nop> 
    let mapleader = "\<space>" 
    let maplocalleader = "\\" 
    nnoremap ; :
    inoremap jk <esc>
    inoremap kj <esc>
" undotree
    nnoremap <F5> :UndotreeToggle<cr>
    let g:undotree_SetFocusWhenToggle=1
    if has("persistent_undo")
        set undodir=~/.undodir/
        set undofile
    endif

" Fzf {{{
    " FzF settings
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
" }}}

" ale settings
    let g:ale_linters = {
        \ 'java' : [
        \ 'javac'
        \ ]
        \}
    let g:ale_lint_on_text_changed = 'never'

" easymotion customization 
    nmap <leader>s <Plug>(easymotion-prefix)s

" snippet config 
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

" change comment style
    autocmd FileType c,cpp,java setlocal commentstring=//\ %s
