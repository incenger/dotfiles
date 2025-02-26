return {
  base46 = {
    theme = "ayu_dark"
  },

  ui = {
    statusline = {
      enabled = true,
      theme = "minimal", -- default/vscode/vscode_colored/minimal
      separator_style = "block",
    },

    tabufline = {
      enabled = false,
    },
  },

  -- term = {
  --   base46_colors = true,
  --   winopts = { number = false, relativenumber = false },
  --   sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  --   float = {
  --     relative = "editor",
  --     row = 0.3,
  --     col = 0.25,
  --     width = 0.5,
  --     height = 0.4,
  --     border = "single",
  --   },
  -- },

  lsp = { signature = true },

  colorify = {
    enabled = false,
  },
}
