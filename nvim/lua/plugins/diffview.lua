-- diffview.nvim
local cb = require("diffview.config").diffview_callback

require("diffview").setup({
	diff_binaries = false, -- Show diffs for binaries
	enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
	use_icons = true, -- Requires nvim-web-devicons
	icons = { -- Only applies when use_icons is true.
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
	},
    file_panel = {
        listing_style = "tree",             -- One of 'list' or 'tree'
        tree_options = {                    -- Only applies when listing_style is 'tree'
            flatten_dirs = true,              -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = {                      -- See ':h diffview-config-win_config'
            position = "left",
            width = 35,
        },
    },
    file_history_panel = {
        log_options = {   -- See ':h diffview-config-log_options'
            git = {
                single_file = {
                    diff_merges = "combined",
                },
                multi_file = {
                    diff_merges = "first-parent",
                },
            }
        },
        win_config = {    -- See ':h diffview-config-win_config'
            position = "bottom",
            height = 16,
        },
    },
	default_args = { -- Default args prepended to the arg-list for the listed commands
		DiffviewOpen = {},
		DiffviewFileHistory = {},
	},
	hooks = {}, -- See ':h diffview-config-hooks'
	key_bindings = {
		disable_defaults = false, -- Disable the default key bindings
		-- The `view` bindings are active in the diff buffers, only when the current
		-- tabpage is a Diffview.
		view = {
			["<C-p>"] = cb("select_next_entry"), -- Open the diff for the next file
			["<C-n>"] = cb("select_prev_entry"), -- Open the diff for the previous file
			["gf"] = cb("goto_file"), -- Open the file in a new split in previous tabpage
			["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
			["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
			["<leader>dp"] = cb("focus_files"), -- Bring focus to the files panel
			["<leader>dt"] = cb("toggle_files"), -- Toggle the files panel.
		},
		file_panel = {
			["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
			["<down>"] = cb("next_entry"),
			["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
			["<up>"] = cb("prev_entry"),
			["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
			["o"] = cb("select_entry"),
			["<2-LeftMouse>"] = cb("select_entry"),
			["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
			["S"] = cb("stage_all"), -- Stage all entries.
			["U"] = cb("unstage_all"), -- Unstage all entries.
			["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
			["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
			["<C-p>"] = cb("select_next_entry"),
			["<C-n>"] = cb("select_prev_entry"),
			["gf"] = cb("goto_file"),
			["<C-w><C-f>"] = cb("goto_file_split"),
			["<C-w>gf"] = cb("goto_file_tab"),
			["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
			["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
			["<leader>dp"] = cb("focus_files"),
			["<leader>dt"] = cb("toggle_files"),
		},
		file_history_panel = {
			["g!"] = cb("options"), -- Open the option panel
			["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
			["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
			["zR"] = cb("open_all_folds"),
			["zM"] = cb("close_all_folds"),
			["j"] = cb("next_entry"),
			["<down>"] = cb("next_entry"),
			["k"] = cb("prev_entry"),
			["<up>"] = cb("prev_entry"),
			["<cr>"] = cb("select_entry"),
			["o"] = cb("select_entry"),
			["<2-LeftMouse>"] = cb("select_entry"),
			["<C-n>"] = cb("select_next_entry"),
			["<C-p>"] = cb("select_prev_entry"),
			["gf"] = cb("goto_file"),
			["<C-w><C-f>"] = cb("goto_file_split"),
			["<C-w>gf"] = cb("goto_file_tab"),
			["<leader>dp"] = cb("focus_files"),
			["<leader>dt"] = cb("toggle_files"),
		},
		option_panel = {
			["<tab>"] = cb("select"),
			["q"] = cb("close"),
		},
	},
})
