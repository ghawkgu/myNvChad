require "nvchad.mappings"

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- CTRL-H in different mode.
map("!", "<C-h>", "<BS>")
map({ "i" }, "<C-h>", "<Left>")

local abbrev = vim.cmd.abbrev
abbrev("w!!", ":w !sudo -A tee %")

map("n", ";", ":", { desc = "enter command mode", nowait = true })

map("n", "<leader>gs", ":Git<CR>", { desc = "Toggle git status"})
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Toggle git blame"})

map("n", "<S-Left>",  ":vertical resize -5<CR>", { desc = "Decrease window width." })
map("n", "<S-Right>", ":vertical resize +5<CR>", { desc = "Increase window height." })
map("n", "<S-Up>",    ":resize +5<CR>",          { desc = "Increase window height." })
map("n", "<S-Down>",  ":resize -5<CR>",          { desc = "Decrease window height." })


map("n", "<C-s>", "<C-S> :%s/<C-R><C-W>//gc<Left><Left><Left>", { desc = "Search & replase current highlighted word" })

map("n", "<leader>?", ":lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostic info.", noremap = true, silent = true })

map("n", "<leader>mdpt", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
map("n", "<leader>mdp0", ":MarkdownPreviewStop<CR>", { desc = "Markdown Preview Stop" })
map("n", "<leader>mdp1", ":MarkdownPreview<CR>", { desc = "Markdown Preview Start" })

map("v", "<C-s>", "y:%s/\\v<C-R>=escape(@\", '.*/\\[]^$+?\\|{}()')<CR>//gc<Left><Left><Left>", { desc = "Search & replase current highlighted word" })

-- nvchad use <leader>fm for formatting the entire file
-- Visual mode: format selected range
-- map("v", "<leader>ff", function()
map("v", "ff", function()
-- @diagnostic disable-next-line: different-requires
  require("conform").format { async = true, lsp_fallback = true, range = true }
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "Indent + Format (with conform)", silent = true })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

map("n", "<leader>ff", ":FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fw", ":FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", ":FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", ":FzfLua help_tags<cr>", { desc = "Help tags" })
