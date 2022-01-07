local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

null_ls.setup({
	on_attach = on_attach,
	sources = {
		formatting.black,
        formatting.isort,
		formatting.stylua,
	},
})
