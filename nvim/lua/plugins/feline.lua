-- NVChad stolen setup
local base16 = require("base16")
local theme = "monokai"
local colors = require("hl_themes." .. theme)

local lsp = require("feline.providers.lsp")

local icon_styles = {
	default = {
		left = "",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	arrow = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},

	block = {
		left = " ",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = "  ",
		position_icon = "  ",
	},

	round = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},

	slant = {
		left = " ",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
}

local mode_colors = {
	["n"] = { "NORMAL", colors.red },
	["no"] = { "N-PENDING", colors.red },
	["i"] = { "INSERT", colors.dark_purple },
	["ic"] = { "INSERT", colors.dark_purple },
	["t"] = { "TERMINAL", colors.green },
	["v"] = { "VISUAL", colors.cyan },
	["V"] = { "V-LINE", colors.cyan },
	[""] = { "V-BLOCK", colors.cyan },
	["R"] = { "REPLACE", colors.orange },
	["Rv"] = { "V-REPLACE", colors.orange },
	["s"] = { "SELECT", colors.nord_blue },
	["S"] = { "S-LINE", colors.nord_blue },
	[""] = { "S-BLOCK", colors.nord_blue },
	["c"] = { "COMMAND", colors.pink },
	["cv"] = { "COMMAND", colors.pink },
	["ce"] = { "COMMAND", colors.pink },
	["r"] = { "PROMPT", colors.teal },
	["rm"] = { "MORE", colors.teal },
	["r?"] = { "CONFIRM", colors.teal },
	["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
	return {
		fg = mode_colors[vim.fn.mode()][2],
		bg = colors.one_bg,
	}
end

-- local config = require("core.utils").load_config().plugins.options.statusline
-- statusline style
local user_statusline_style = "block"
local statusline_style = icon_styles[user_statusline_style]
-- if show short statusline on small screens
local shortline = true

-- Initialize the components table
local components = {
	active = {},
	inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

components.active[1][1] = {
	provider = statusline_style.main_icon,

	hl = {
		fg = colors.statusline_bg,
		bg = colors.nord_blue,
	},

	-- right_sep = { str = statusline_style.right, hl = {
	--         fg = colors.nord_blue,
	--         bg = colors.lightbg,
	-- } },
}

components.active[1][2] = {
	provider = function()
		return " " .. mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = chad_mode_hl,
}

components.active[1][3] = {}

components.active[1][4] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist("Error")
	end,

	hl = { fg = colors.red },
	icon = "  ",
}

components.active[1][5] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist("Warn")
	end,
	hl = { fg = colors.yellow },
	icon = "  ",
}

components.active[1][6] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist("Hint")
	end,
	hl = { fg = colors.grey_fg2 },
	icon = "  ",
}

components.active[1][7] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist("Info")
	end,
	hl = { fg = colors.green },
	icon = "  ",
}

components.active[2][1] = {
	provider = {
		name = "file_info",
		opts = {
			type = "relative-short",
			file_modified_icon = "",
		},
	},
	short_provider = {
		name = "file_info",
		opts = {
			type = "base-only",
			file_modified_icon = "",
		},
	},
	hl = {
		fg = colors.white,
	},
}

components.active[3][1] = {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 70
	end,
	hl = {
		fg = colors.grey_fg2,
		bg = colors.statusline_bg,
	},
	icon = "  ",
	right_sep = {
		str = " ",
		hl = {
			bg = colors.statusline_bg,
		},
	},
}

components.active[3][2] = {
	provider = "git_diff_added",
	hl = {
		fg = colors.grey_fg2,
		bg = colors.statusline_bg,
	},
	icon = "  ",
}
-- diffModfified
components.active[3][3] = {
	provider = "git_diff_changed",
	hl = {
		fg = colors.grey_fg2,
		bg = colors.statusline_bg,
	},
	icon = "  ",
}
-- diffRemove
components.active[3][4] = {
	provider = "git_diff_removed",
	hl = {
		fg = colors.grey_fg2,
		bg = colors.statusline_bg,
	},
	icon = "  ",
}

components.active[3][5] = {
	provider = " " .. statusline_style.left,
	hl = {
		-- fg = colors.one_bg2,
		bg = colors.statusline_bg,
	},
}

components.active[3][6] = {
	provider = "line_percentage",

	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 90
	end,

	hl = {
		fg = colors.green,
		bg = colors.statusline_bg,
	},
	right_sep = {
		str = " ",
		hl = {
			bg = colors.statusline_bg,
		},
	},
}
components.active[3][7] = {
	provider = statusline_style.right,
	hl = {
		fg = colors.statusline_bg,
		bg = colors.nord_blue,
	},
}

components.inactive[1] = { {} }
components.inactive[2] = {
	{
		provider = {
			name = "file_info",
			opts = {
				file_modified_icon = "",
			},
		},
		hl = {
			fg = colors.white,
		},
	},
}
components.inactive[3] = { {} }

require("feline").setup({
	colors = {
		bg = colors.statusline_bg,
		fg = colors.fg,
	},
	components = components,
})
