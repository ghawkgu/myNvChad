---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- Disable the blame_line from gitsigns
    ["<leader>gb"] = ""
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- Vim Fugitive
    ["<leader>gs"] = { ":Git<CR>" },
    ["<Leader>gb"] = { ":Git blame<CR>" },
    -- map("n", "<Leader>gs", ":Git<CR>", opt)
    -- map("n", "<Leader>gh", ":diffget //2<CR>", opt)
    -- map("n", "<Leader>gl", ":diffget //3<CR>", opt)
    -- map("n", "<Leader>gb", ":Git blame<CR>", opt)

    ["<S-Left>"] = { ":vertical resize -5<CR>", "Decrease window width." },
    ["<S-Right>"] = { ":vertical resize +5<CR>", "Increase window height." },
    ["<S-Up>"] = { ":resize +5<CR>", "Increase window height." },
    ["<S-Down>"] = { ":resize -5<CR>", "Decrease window height." },

    ["<C-s>"] = { "<C-S> :%s/<C-R><C-W>//gc<Left><Left><Left>", "Search & replase current highlighted word" },

    ["<leader>?"] = { ":lua vim.diagnostic.open_float()<CR>", "Show diagnostic info.", opts = { noremap = true, silent = true } },
  },

  v = {
    ["<C-s>"] = { "y:%s/<C-R>=escape(@\", '.*/\\[]^$+?\\|{}()')<CR>//gc<Left><Left><Left>", "Search & replase current highlighted word" },
  },
}

-- FIXME remap the open vertical action to "s" key
-- M.nvimtree = {
--   n = {
--     ["s"] = {
--       function()
--         require("nvim-tree.api").node.open.vertical()
--       end,
--       "Open file in a vertical window",
--     },
--   },
-- }

-- Extras example
-- M.symbols_outline = {
--   n = {
--     ["<leader>cs"] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
--   },
-- }

-- more keybinds!

return M
