local colors = require("base46").get_theme_tb "base_30"
-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

--- Remove all trailing whitespace on save
-- autocmd("BufWritePre", {
--   command = [[:%s/\s\+$//e]],
--   group = augroup("TrimWhiteSpaceGrp", { clear = true }),
-- })

vim.env.SUDO_ASKPASS = '/usr/local/bin/ssh-askpass'
-- vim.cmd [[set whichwrap=<>[]hl,b,s]]
-- vim.cmd [[set whichwrap=<>[],b,s]]
vim.opt.whichwrap = "<>[]bs"

-- Set listchars for whitespace display
vim.opt.listchars = {
    space = "·",
    tab = "▸ ",
    eol = "¬",
    extends = "❯",
    precedes = "❮",
    nbsp = "_",
    trail = "-"
}

-- Highlight groups for special keys and redundant spaces
vim.api.nvim_set_hl(0, "SpecialKey", { ctermbg = "yellow", standout = true })
vim.api.nvim_set_hl(0, "RedundantSpaces", { ctermbg = "Grey", bg = "#ffddcc", standout = true })

-- Highlight of redundant spaces is disabled as nvcheatsheet is highlighted as well
-- vim.fn.matchadd("RedundantSpaces", [[\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!]])

-- Highlight CursorLine conditionally
local function enter_insert_mode()
    local excluded_filetypes = { "NvimTree", "Telescope", "TelescopePrompt" }
    if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
        return
    end
    vim.opt_local.listchars:remove("eol:¬")
    -- vim.opt_local.list = true
    vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = colors.one_bg2 })

    vim.schedule(function()
        if vim.fn.mode() == "i" then
            vim.opt_local.list = true
        end
    end)
end

local function exit_insert_mode()
    local excluded_filetypes = { "NvimTree", "Telescope", "TelescopePrompt" }
    if vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
        return
    end
    vim.opt_local.listchars:append("eol:¬")
    -- vim.opt_local.list = false
    vim.api.nvim_set_hl(0, "CursorLine", { underline = false, bg = colors.one_bg2 })

    vim.schedule(function()
        if vim.fn.mode() ~= "i" then
            vim.opt_local.list = false
        end
    end)
end

vim.api.nvim_create_autocmd("InsertEnter", { callback = enter_insert_mode })
vim.api.nvim_create_autocmd("InsertLeave", { callback = exit_insert_mode })
