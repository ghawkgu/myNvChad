local M = {}

---@type NvStatusLineConfig
M.override = {
  -- default order
  -- order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
  order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "abs_cursor" },
  modules = {
    abs_cursor = "%#St_pos_sep#" .. "" .. "%#St_pos_icon# %#St_pos_text# %l:%c | %p %% "
  },
}


return M
