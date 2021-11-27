" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

" Plug {{{

call plug#begin('~/.local/share/nvim/plugged')

" LANGUAGE PACKAGES {{{

""" Language Support
Plug 'sheerun/vim-polyglot'

""" Builtin LSP 
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'

""" Autocomplete engine
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'

""" Enhance LSP
" Plug 'ray-x/lsp_signature.nvim'

""" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'folke/trouble.nvim'


""" Semantic Highlighting
Plug 'numirias/semshi', {'for':'python', 'do': ':UpdateRemotePlugins'} "For Python
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}

""" Docs Generator
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
" Plug 'yggdroot/indentline'

""" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'fannheyward/telescope-coc.nvim'


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

""" Windows
Plug 't9md/vim-choosewin'


" }}} GENERAL "

" UI {{{
""" Theme
Plug 'srcery-colors/srcery-vim'
Plug 'NvChad/nvim-base16.lua'


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
    " lua require("plugins.theme")

	set mouse=a
	set number
	set relativenumber
    set mousehide
    set lazyredraw "Fixlag while scolling
    set cursorline " Highlight current line
    set guicursor=
    set signcolumn=yes
    set splitbelow splitright
    set fillchars+=vert:\|
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

" }}} Content "

" Filetype {{{

	filetype indent on
	filetype on
	filetype plugin indent on
	syntax enable

    """ Python
    let g:python3_host_prog = "$HOME/anaconda3/bin/python3.8"


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
                \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

    " Add an AllFiles variation that ignores .gitignore files
    command! -bang -nargs=? -complete=dir AllFiles
                \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

    nnoremap <silent> <C-p>      :GFiles<CR>
    nnoremap <silent> <leader>fb  :Buffers<CR>
    nnoremap <silent> <leader>ff  :Files<CR>
    nnoremap <silent> <leader>fF  :AllFiles<CR>
    nnoremap <silent> <leader>fl  :Lines<CR>
    nnoremap <silent> <leader>fg  :execute 'Rg'  input('Rg/') <CR>
    " Edit neovim config
    nnoremap <silent> <leader>fd  :Files ~/.config/<CR>
    "Search current word in current working directory 
    nnoremap <silent> <leader>fw  :execute 'Rg' expand('<cword>') <CR>

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


    " floating fzf window with borders
    function! CreateCenteredFloatingWindow()
        let width = min([&columns - 4, max([80, &columns - 20])])
        let height = min([&lines - 4, max([20, &lines - 10])])
        let top = ((&lines - height) / 2) - 1
        let left = (&columns - width) / 2
        let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

        let top = "╭" . repeat("─", width - 2) . "╮"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "╰" . repeat("─", width - 2) . "╯"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating
        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        au BufWipeout <buffer> exe 'bw '.s:buf
    endfunction

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
    nmap <leader>gs :G<CR>
    nmap <leader>gv :GV<CR>
" }}}

" vim-doge {{{
    let g:doge_doc_standard_python="google"
    let g:doge_mapping='<leader>gd'
" }}}

" vim-choosewin{{{
    nmap  -  <Plug>(choosewin)
" }}}

" indent-blankline.nvim {{{
    " Fix cursorline leaves artifacts
    " https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
    lua require("plugins.indent_blankline")
    set colorcolumn=99999
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
    lua require('plugins.nvim-tree')
    nnoremap <leader>e <cmd>NvimTreeToggle<cr>
" }}}

" gitsigns {{{
    lua require('plugins.gitsigns')
" }}}

" feline {{{
    lua require('plugins.feline')
" }}}


" LSP Completion {{{
    lua require('plugins.lsp')
    lua require('plugins.nvim-cmp')
" }}}

" Snippet Engine {{{
    lua require('plugins.luasnip')
" }}}

" Trouble.nvim {{{
    lua require('plugins.trouble')
" }}}
