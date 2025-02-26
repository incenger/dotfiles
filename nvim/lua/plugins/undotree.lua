return {
    'mbbill/undotree',
    config = function()
        -- Keymap for UndotreeToggle
        vim.keymap.set('n', '<F5>', ':UndotreeToggle<cr>')

        -- Persistent undo configuration
        if vim.fn.has("persistent_undo") == 1 then
            vim.opt.undodir = vim.fn.expand("~/.undodir/")
            vim.opt.undofile = true
        end

        vim.g.undotree_WindowLayout = vim.g.undotree_WindowLayout or 2
        vim.g.undotree_SetFocusWhenToggle = vim.g.undotree_SetFocusWhenToggle or 1
    end

}
