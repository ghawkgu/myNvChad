vim.keymap.set("!", "<C-h>", "<BS>")
vim.keymap.set({ "i" }, "<C-h>", "<Left>")

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  -- theme = "onedark",
  -- theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  theme = 'jellybeans',
  telescope = { style = "bordered" },

  -- tabufline = {
  --   enabled = true,
  -- },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
