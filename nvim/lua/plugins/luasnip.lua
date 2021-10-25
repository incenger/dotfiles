local luasnip = require('luasnip')

--- Add snippet
local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. '/.local/share/nvim/plugged/'
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end
    return paths
end


luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}
require("luasnip.loaders.from_vscode").lazy_load({paths = snippets_paths()})


--- Mapping
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use tab for jumping only, not for expanding
_G.tab_complete = function()
    if luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-jump-next")
    elseif check_back_space() then
        return t "<Tab>"
    end
    return ""
end
_G.s_tab_complete = function()
    if luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-y>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-y>", "<Plug>luasnip-next-choice", {})
