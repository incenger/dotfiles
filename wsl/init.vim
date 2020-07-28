" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:


" Plug {{{

call plug#begin('~/.local/share/nvim/plugged')

" LANGUAGE PACKAGES {{{

""" LSP Neovim
" Plug 'neovim/nvim-lsp'

""" Language Support
Plug 'sheerun/vim-polyglot'

""" Coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jsfaint/coc-neoinclude'

""" Snippet 
Plug 'honza/vim-snippets'

""" Inclue Path
Plug 'Shougo/neoinclude.vim'


""" Function Signature in StatusLine
Plug 'Shougo/echodoc.vim'

""" Semantic Highlighting
Plug 'numirias/semshi', {'for':'python', 'do': ':UpdateRemotePlugins'} "For Python
Plug 'octol/vim-cpp-enhanced-highlight', {'for' : 'cpp'} "For CPP

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

""" Tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

""" Folder Tree
" Plug 'scrooloose/nerdtree'
 Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

""" Indentation
Plug 'yggdroot/indentline'

""" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
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


" }}} GENERAL "

" UI {{{
""" Theme
Plug 'srcery-colors/srcery-vim'
Plug 'sjl/badwolf'

""" Status Line
" Plug 'taigacute/spaceline.vim'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim' "For Tmux

" }}} UI "

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
    set mousehide
    set lazyredraw "Fixlag while scolling
    set cursorline " Highlight current line
    set guicursor=
    set signcolumn=yes

" }}} UI "

" Content {{{

	set history=1000
    set noswapfile
    set autoread "automatically load buffer
    set noshowmode
    set encoding=utf-8
    set shortmess+=c

" }}} Content "

" Filetype {{{

	filetype indent on
	filetype on
	filetype plugin indent on
	syntax enable

    """ Python
    let g:python3_host_prog = "/home/eddie/anaconda3/bin/python3.7"
    autocmd BufNewFile,BufRead *.py set filetype=python
    autocmd BufNewFile,BufRead *.py
                \ set tabstop=4 |
                \ set softtabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |
                \ set fileformat=unix


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
	set foldmethod=indent
	set foldlevelstart=2
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
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

" }}} Movement "

" General {{{

	nnoremap <space> <nop>
	let mapleader = "\<space>"
	let maplocalleader = "\\"
	nnoremap ; :
	inoremap jk <esc>
	inoremap kj <esc>
    "Copy content of the whole file
    nnoremap <leader>a gg"+yG
    " use tab to forward cycle
    inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
    " use s-tab to backward cycle
    inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
    " Delete trailing whitespace
    nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
" }}} General "

" Folding {{{
    nmap <leader>z0 :set foldlevel=0<CR>
    nmap <leader>z1 :set foldlevel=1<CR>
    nmap <leader>z2 :set foldlevel=2<CR>
    nmap <leader>z3 :set foldlevel=3<CR>
    nmap <leader>z4 :set foldlevel=4<CR>
    nmap <leader>z5 :set foldlevel=5<CR>
    nmap <leader>z6 :set foldlevel=6<CR>
    nmap <leader>z7 :set foldlevel=7<CR>
    nmap <leader>z8 :set foldlevel=8<CR>
    nmap <leader>z9 :set foldlevel=9<CR>

" }}} Folding "



""" PLUGIN CONFIG 

" Vista {{{

	nnoremap <F7> :Vista!!<CR>
    let g:vista#renderer#enable_icon = 1

" }}} Vista 

" NerdTree {{{

	"nnoremap <F6> :NERDTreeToggle<CR>
	"let NERDTreeShowHidden=0 "not show dot files
	""close nerdtree when closing vim
	"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    "let g:NERDTreeHighlightCursorline = 0
    "let g:NERDTreeSyntaxDisableDefaultExtensions = 1
    "let g:NERDTreeDisableExactMatchHighlight = 1
    "let g:NERDTreeDisablePatternMatchHighlight = 1
    
" }}} NerdTree "

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
    function! s:fzf_statusline()
        " Override statusline as you like
        highlight fzf1 ctermfg=161 ctermbg=251
        highlight fzf2 ctermfg=23 ctermbg=251
        highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
    endfunction

    " This is the default extra key bindings
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }

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
	nnoremap <silent> <leader>f  :Files<CR>

	imap <C-x><C-f> <plug>(fzf-complete-file-ag)
	imap <C-x><C-b> <plug>(fzf-complete-line)

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
    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " [[B]Commits] Customize the options used by 'git log':
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)



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

" Lightline {{{
       let g:lightline = {
                \'colorscheme': 'srcery',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch'], ['filename', 'cocstatus' ]],
                \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ]]
                \ },
                \ 'component_function': {
                \     'filetype':   'CustomLightlineFiletype',
                \     'fileformat': 'CustomLightlineFileformat',
                \      'gitbranch': 'fugitive#head',
                \     'cocstatus': 'coc#status',
                \   }
                \ }

    " Force lightline update
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

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
" }}} Lightline "

" Semshi {{{
    let g:semshi#error_sign=v:false
    let g:semshi#mark_selected_nodes=1
" }}} Semshi "

" Coc.nvim {{{
    let g:coc_snippet_next = '<TAB>'
    let g:coc_snippet_prev = '<S-TAB>'
    let g:coc_status_error_sign = '•'
    let g:coc_status_warning_sign = '•'
    set updatetime=300

    let g:coc_global_extensions =[
                \'coc-snippets',
                \'coc-git',
                \'coc-json',
                \'coc-python',
                \'coc-explorer']


    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " navigate chunks of current buffer
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    " show chunk diff at current position
    nmap gs <Plug>(coc-git-chunkinfo)

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
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Ctrl Space to trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)


    " Close the preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>cd  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
    " Search workspace symbols
    nnoremap <silent> <leader>cs  :<C-u>CocList symbols<cr>

    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <Tab>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<Tab>" :
                \ coc#refresh()

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " coc-explorer
    let g:coc_explorer_global_presets = {
                \   '.vim': {
                \      'root-uri': '~/.vim',
                \   },
                \   'floating': {
                \      'position': 'floating',
                \   },
                \   'floatingLeftside': {
                \      'position': 'floating',
                \      'floating-position': 'left-center',
                \      'floating-width': 50,
                \   },
                \   'floatingRightside': {
                \      'position': 'floating',
                \      'floating-position': 'left-center',
                \      'floating-width': 50,
                \   },
                \   'simplify': {
                \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]',
                \     'file.child.labeling.template': '[diagnosticWarning][diagnosticError][size][modified][readonly]'
                \   }
                \ }
    noremap <silent> <leader>e :CocCommand explorer<CR>
            " \ --toggle
            " \ --sources=buffer+,file+
            " \ <CR>
" }}} Coc-nvim "

" Spaceline {{{ 
    let g:spaceline_line_symbol = 0
    let g:spaceline_seperate_style= 'slant'
" }}} Spaceline
