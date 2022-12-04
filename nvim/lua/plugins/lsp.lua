local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- Better signature
	-- require "lsp_signature".on_attach()

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- Use trouble.nvim instead
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<A-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.format({asynce = true})<CR>", opts)
	-- No useful use case so far
	-- if client.resolved_capabilities.document_range_formatting then
	--     buf_set_keymap('v', '<space>cf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
	-- end
	buf_set_keymap("n", "<space>ds", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- Use trouble.nvim instead
	-- buf_set_keymap('n', '<space>dq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- true/false - enable/disable the server using default configuration
-- dict -  customized config
local servers = {
	-- pylsp = true,
	-- ccls = true,
    clangd = true,
	vimls = true,
    pyright = true,
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, config)

	nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end


local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- replace the default lsp diagnostic symbols
lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

-- Display virtual text for error only
vim.diagnostic.config({
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
		source = "if_many",
	},
	float = {
		source = "always",
	},
	underline = false,
})
