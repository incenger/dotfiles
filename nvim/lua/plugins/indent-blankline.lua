return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        local hooks = require("ibl.hooks")
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_space_indent_level
        )
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_tab_indent_level
        )
        require("ibl").setup()
    end
}
