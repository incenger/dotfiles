return  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        local fzf_lua = require("fzf-lua")
        fzf_lua.setup {}

        -- Keymaps
        local opts = { silent = true }
        vim.keymap.set('n', '<C-p>', fzf_lua.git_files, opts)
        vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, opts)
        vim.keymap.set('n', '<leader>ff', fzf_lua.files, opts)
        vim.keymap.set('n', '<leader>fl', fzf_lua.lines, opts)
        vim.keymap.set('n', '<leader>fc', fzf_lua.command_history, opts)

        -- vim.keymap.set('n', '<leader>fF', ':AllFiles<CR>', opts)
        -- vim.keymap.set('n', '<leader>fg', function() vim.cmd("execute 'Rg' input('Rg/')") end, opts)
        -- Edit neovim config
        -- vim.keymap.set('n', '<leader>fd', ':Files ~/.config/<CR>', opts)
        -- vim.keymap.set('n', '<leader>fv', ':Files ~/.config/nvim<CR>', opts)
        -- Search current word in current working directory
        -- vim.keymap.set('n', '<leader>fw', function() vim.cmd("execute 'Rg' expand('<cword>')") end, opts)
        -- Panes (windows in all tabs) navigation
        -- vim.keymap.set('n', '<leader>fp', '<cmd>Windows<CR>', opts)

    end
}
