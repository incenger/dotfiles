return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            renderer = {
                icons = {
                    show = {
                        folder = true,
                        folder_arrow = true,
                        file = true,
                        git = false,
                    },
                },
            },
        }
        local api = require("nvim-tree.api")
        vim.keymap.set("n", "<leader>e", api.tree.toggle, { noremap = true, desc = "Toggle nvim-tree" })
    end
}
