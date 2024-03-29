" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

" Install vim-plug if not found {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync
endif

" Plug {{{

call plug#begin('~/.local/share/nvim/plugged')

" LANGUAGE PACKAGES {{{

""" Language Support
Plug 'sheerun/vim-polyglot'

""" Builtin LSP 
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'

""" Null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'

""" Autocomplete engine
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'

""" LSP Enhancement
Plug 'j-hui/fidget.nvim'
Plug 'folke/trouble.nvim'

""" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'


""" Semantic Highlighting
Plug 'numirias/semshi', {'for':'python', 'do': ':UpdateRemotePlugins'} "For Python
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}

""" Docs Generator
" Tree-sitter based doc gen plugin: https://github.com/nvim-treesitter/nvim-tree-docs
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }


" }}} LANGUAGE PACKAGES "

" GENERAL {{{

""" Quickly Moving Around Text
Plug 'easymotion/vim-easymotion'

""" History Tree of File
Plug 'mbbill/undotree'

""" Bracket surrounding text
Plug 'tpope/vim-surround'

""" Commenting
Plug 'tpope/vim-commentary'

""" Generate and Manage Tags
Plug 'liuchengxu/vista.vim'

""" Window Navigator
Plug 'christoomey/vim-tmux-navigator'

""" Folder Tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

""" Indentation
Plug 'lukas-reineke/indent-blankline.nvim'

""" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'


Plug 'google/vim-searchindex'

""" Register Manager
Plug 'junegunn/vim-peekaboo'

""" Pairing
Plug 'jiangmiao/auto-pairs'

""" Executing Unix Command
Plug 'tpope/vim-eunuch'

""" Git
Plug 'tpope/vim-fugitive'  "Git Wrapper
Plug 'junegunn/gv.vim'     "Git Commit Browser
Plug 'lewis6991/gitsigns.nvim' 
Plug 'sindrets/diffview.nvim'

""" Windows
Plug 't9md/vim-choosewin'

""" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag':'v2.*'}

" }}} GENERAL "

" UI {{{
""" Theme
Plug 'srcery-colors/srcery-vim'
Plug 'NvChad/base46', {'commit': 'dbd746da1b1ab43faf8aad2ba5ad0be3d43eba86'}


""" Tabline (no buffers) 
Plug 'alvarosevilla95/luatab.nvim'

""" Status Line
Plug 'famiu/feline.nvim'

" }}} UI 

call plug#end()

" }}} Plug "

""" GENERAL CONFIG

" Indentation {{{

    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set smarttab
    set autoindent
    set smartindent

" }}} Indentation "

" UI {{{

    set termguicolors
    colorscheme srcery
	set mouse=a

	set number
	set relativenumber
    set lazyredraw "Fixlag while scolling
    set cursorline " Highlight current line
    set guicursor=
    set signcolumn=yes
    set splitbelow splitright
    " Highlight on yank
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{timeout=200}
    augroup END

" }}} UI "

" Content {{{

	set history=1000
    set noswapfile
    set autoread "automatically load buffer
    set noshowmode
    set encoding=utf-8
    set shortmess+=c
    set scrolloff=10
    " The formatoption is override by vim-polyglot plugin.
    autocmd FileType * set formatoptions-=o

" }}} Content "

" Filetype {{{

	filetype plugin indent on
	syntax enable

    """ Python
    let g:python3_host_prog = "$HOME/anaconda3/bin/python3.9"


" }}} Filetype "

" Searching {{{
    set incsearch
    set nohlsearch
	set ignorecase
	set smartcase
    set inccommand=split
" }}} Searching "

" Folding {{{
	set foldenable
	" set foldmethod=indent
	" set foldlevelstart=99
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
	set foldnestmax=10
" }}} Folding "

" Windows {{{

    set noequalalways
    set hidden

" }}} Windows "


""" MAPPING

" Movement {{{

    nnoremap j gj
    nnoremap k gk

" }}} Movement "

" General {{{

	nnoremap <space> <nop>
	let mapleader = "\<space>"
	let maplocalleader = "\\"
	nnoremap ; :
	inoremap jk <esc>

    "Copy content of current buffer into clipboard
    nnoremap <leader>a :%y+<CR>

    " Delete trailing whitespace
    nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

    " Move visual selected lines up and down, followed by indentation
    xnoremap J :m '>+1<CR>gv=gv
    xnoremap K :m '<-2<CR>gv=gv

" }}} General "

""" PLUGIN CONFIG

" Vista {{{

	nnoremap <F7> :Vista!!<CR>
    let g:vista#renderer#enable_icon = 1

" }}} Vista

" Undo Tree {{{

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

" }}} Undo Tree "

" EasyMotion {{{

	nmap <leader>s <Plug>(easymotion-prefix)s

" }}} EasyMotion "

" Comment {{{

    autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" }}} Comment "

" Fzf {{{

    " Use rg if possible
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore'
    endif

    " Consistent top to bottom result
    let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

    " This is the default extra key bindings, used when sink is not defined 
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit',
                \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

    " Customise the Files command to use rg which respects .gitignore files
    command! -bang -nargs=? -complete=dir Files
                \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'source': 'rg --files --hidden' }), <bang>0))

    " Add an AllFiles variation that ignores .gitignore files
    command! -bang -nargs=? -complete=dir AllFiles
                \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

    nnoremap <silent> <C-p>      :GFiles<CR>
    nnoremap <silent> <leader>fb  :Buffers<CR>
    nnoremap <silent> <leader>ff  :Files<CR>
    nnoremap <silent> <leader>fF  :AllFiles<CR>
    nnoremap <silent> <leader>fl  :Lines<CR>
    nnoremap <silent> <leader>fg  :execute 'Rg'  input('Rg/') <CR>
    " Edit neovim config
    nnoremap <silent> <leader>fd  :Files ~/.config/<CR>
    nnoremap <silent> <leader>fv  :Files ~/.config/nvim<CR>
    "Search current word in current working directory 
    nnoremap <silent> <leader>fw  :execute 'Rg' expand('<cword>') <CR>
    " Panes (windows in all tabs) navigation
    nnoremap <silent> <leader>fp  <cmd>Windows <CR>

    " Command history
    nnoremap <silent> <leader>fc  :History: <CR>
    " nnoremap <silent> <leader>?  :History/<CR>
    " nnoremap <silent> <leader>m  :Marks<CR>
    " nnoremap <silent> <leader>p  :Commands<CR>

    inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
    imap <c-x><c-b> <plug>(fzf-complete-line)
    
    " Call rg with flag
    command! -bang -nargs=* Rga
                \   call fzf#vim#grep(
                \   "rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1,
                \   fzf#vim#with_preview(), <bang>0)


    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 0

    " [[B]Commits] Customize the options used by 'git log':
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'


    " let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" }}} Fzf "

" Cpp-enhanced-highlight {{{
    let g:cpp_class_scope_highlight = 0
    let g:cpp_member_variable_highlight = 1
    let g:cpp_experimental_template_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_class_decl_highlight = 1
" }}} Cpp-enhanced-highlight "

" EchoDoc {{{
	let g:echodoc_enable_at_startup = 1
" }}} EchoDoc "

" Semshi {{{
    let g:semshi#error_sign=v:false
    let g:semshi#mark_selected_nodes=1
" }}} Semshi "

" vim-fugitive {{{
    nmap <leader>gj :diffget //3<CR>
    nmap <leader>gf :diffget //2<CR>
    nmap <leader>gs :tab G<CR>
    nmap <leader>gv :GV<CR>
" }}}

" vim-doge {{{
    let g:doge_doc_standard_python="google"
    let g:doge_mapping='<leader>gd'
" }}}

" vim-choosewin{{{
    nmap  -  <Plug>(choosewin)
" }}}

" Lua plugins {{{
    lua require("plugins")
" }}}

" telescope.nvim {{{
    " source the config file won't reload your lua config
    " lua require('plugins.telescope')
    " nnoremap <C-p>      <cmd>Telescope git_files<cr>
    " nnoremap <leader>ff <cmd>Telescope find_files<cr>
    " nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    " nnoremap <leader>fw <cmd>Telescope grep_string<cr>
    " nnoremap <leader>fb <cmd>Telescope buffers<cr>
    " nnoremap <leader>fc <cmd>Telescope command_history<cr>
    " nnoremap <leader>fl <cmd>lua require('plugins.telescope').curbuf() <cr>
    " nnoremap <leader>fv <cmd>lua require('plugins.telescope').edit_neovim() <cr>
" }}}

" nvim-tree {{{
    nnoremap <leader>e <cmd>NvimTreeToggle<cr>
" }}}

" diffview.nvim {{{
    nnoremap <leader><leader>d <cmd>DiffviewOpen<cr>
    nnoremap <leader><leader>h <cmd>DiffviewFileHistory<cr>
" }}}
