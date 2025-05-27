local options = {
  formatters_by_ft = {
    -- lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    vue = { "prettier" },
    typescript = { "prettier" },
    javascript = { "prettier" },

    cpp = { "clang_format" },
    python = { "autopep8", "isort", "black" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    go = { "gofumpt" },
    -- dart = { lsp_fallback = true },
    -- ruby = not configured
    ruby = { "rubyfmt" }
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
