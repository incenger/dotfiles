vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 4
vim.opt.expandtab      = true
vim.opt.autoindent     = true
vim.opt.smartindent    = true

vim.opt.termguicolors  = true
vim.opt.mouse          = 'a'
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.lazyredraw     = true
vim.opt.cursorline     = true
vim.opt.guicursor      = ""
vim.opt.signcolumn     = "yes"
vim.opt.splitbelow     = true
vim.opt.splitright     = true

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank { timeout = 200 }
    end,
    desc = "Highlight yanked text"
})

vim.opt.history = 1000
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.showmode = false
vim.opt.encoding = 'utf-8'
vim.opt.shortmess:append('c')
vim.opt.scrolloff = 10


-- TODO: What are equivalant options in Lua?
-- filetype plugin indent on
-- syntax enable

vim.g.python3_host_prog = "$HOME/local_python/bin/python3"

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>',
    { desc = "Clear highlights on search when pressing <Esc> in normal mode" })
vim.opt.inccommand = "split"

vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 10

vim.opt.equalalways = true
vim.opt.hidden = true

vim.g.have_nerd_font = true

vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("i", "jk", "<esc>", { noremap = true })
vim.keymap.set("n", " ", "<nop>", { noremap = true })

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>a", ":%y+<CR>", { noremap = true, desc = "Yank entire buffer to system clipboard" })
vim.keymap.set("n", ",<Space>", function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[silent! keeppatterns %substitute/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, cursor_pos)
    end,
    { noremap = true, silent = true, desc = "Remove trailing whitespace (keep cursor)" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move visual block up, followed by indentation" })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move visual block down, followed by indentation" })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Need to define the path before lazy config
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"


require('lazy').setup({

    {
        "nvchad/ui",
        priority = 1000,
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-tree/nvim-web-devicons",
                lazy = true
            },
            {
                "nvchad/base46",
                lazy = true,
                build = function()
                    require("base46").load_all_highlights()
                end,
            },
        },
        config = function()
            require "nvchad"
            for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
                dofile(vim.g.base46_cache .. v)
            end
        end
    },


    'tpope/vim-sleuth',

    'tpope/vim-surround',

    'tpope/vim-commentary',

    'tpope/vim-eunuch',

    'christoomey/vim-tmux-navigator',

    'google/vim-searchindex',

    'junegunn/vim-peekaboo',

    'jiangmiao/auto-pairs',

    { 'alvarosevilla95/luatab.nvim', opts = {} },

    {
        't9md/vim-choosewin',
        config = function()
            vim.keymap.set("n", "-", "<Plug>(choosewin)", { noremap = true, desc = "Choose window to jump to" })
        end

    },

    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gj", ":diffget //3<CR>")
            vim.keymap.set("n", "<leader>gf", ":diffget //2<CR>")
            vim.keymap.set("n", "<leader>gs", ":tab G<CR>")
        end
    },

    {
        -- Git Commit Browser
        'junegunn/gv.vim',
        config = function()
            vim.keymap.set("n", "<leader>gv", ":GV<CR>")
        end
    },

    require "plugins/lsp",

    require "plugins/nvim-cmp",

    require "plugins/nvim-treesitter",

    require "plugins/nvim-tree",

    {
        'ggandor/leap.nvim',
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, '<leader>s', '<Plug>(leap)')
        end
    },

    require "plugins/indent-blankline",

    require "plugins/toggleterm",

    require "plugins/gitsigns",

    require "plugins/fzf",

    require "plugins/undotree",

    require "plugins/nvim-lint",

    require "plugins/trouble"

})
