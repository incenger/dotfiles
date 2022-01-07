local themes = require("telescope.themes")

require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("coc")

-- Customize function
local _custom = {}

-- Search line in current buffer
_custom.curbuf = function()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})
	require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

_custom.edit_neovim = function()
	local opts_with_preview, opts_without_preview

	opts_with_preview = {
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
		cwd = "~/.config/nvim",

		layout_strategy = "flex",
		layout_config = {
			width = 0.9,
			height = 0.8,

			horizontal = {
				width = { padding = 0.15 },
			},
			vertical = {
				preview_height = 0.75,
			},
		},
	}

	opts_without_preview = vim.deepcopy(opts_with_preview)
	opts_without_preview.previewer = false

	require("telescope.builtin").find_files(opts_with_preview)
end

return _custom
