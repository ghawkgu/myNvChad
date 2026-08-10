require "nvchad.mappings"

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- CTRL-H in different mode.
map("!", "<C-h>", "<BS>")
map({ "i" }, "<C-h>", "<Left>")

local abbrev = vim.cmd.abbrev
abbrev("w!!", "<cmd>w !sudo -A tee %<CR>")

map("n", ";", ":", { desc = "enter command mode", nowait = true })

map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Toggle git status"})
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Toggle git blame"})

map("n", "<S-Left>",  "<cmd>vertical resize -5<CR>", { desc = "Decrease window width." })
map("n", "<S-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase window height." })
map("n", "<S-Up>",    "<cmd>resize +5<CR>",          { desc = "Increase window height." })
map("n", "<S-Down>",  "<cmd>resize -5<CR>",          { desc = "Decrease window height." })

map("n", "<C-s>", "<C-S> :%s/<C-R><C-W>//gc<Left><Left><Left>", { desc = "Search & replase current highlighted word" })

map("n", "<leader>?", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostic info.", noremap = true, silent = true })

map("n", "<leader>mdpt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
map("n", "<leader>mdp0", "<cmd>MarkdownPreviewStop<CR>", { desc = "Markdown Preview Stop" })
map("n", "<leader>mdp1", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview Start" })

map("v", "<C-s>", "y:%s/\\v<C-R>=escape(@\", '.*/\\[]^$+?\\|{}()')<CR>//gc<Left><Left><Left>", { desc = "Search & replase current highlighted word" })

-- nvchad use <leader>fm for formatting the entire file
-- Visual mode: format selected range
map("v", "ff", function()
  -- Extract the visual selection marks
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  -- Handle reverse selection (selecting from bottom to top)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Get the end line text to safely determine the end column character
  local lines = vim.api.nvim_buf_get_lines(0, end_line - 1, end_line, true)
  local end_col = #lines > 0 and #lines[1] or 0

  -- Call conform with the exact visual range coordinates
  require("conform").format({
    async = true,
    lsp_fallback = true,
    range = {
      start = { start_line, 0 },
      ["end"] = { end_line, end_col },
    },
  })

  -- Clear the visual selection and return to normal mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "Indent + Format (with conform)", silent = true })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })

map("n", "[f", "<cmd>colder<CR>", { desc = "Quickfix stack older" })
map("n", "]f", "<cmd>cnewer<CR>", { desc = "Quickfix stack newer" })

map("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
map("n", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Explain Code" })
map("v", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Chat about selection" })
