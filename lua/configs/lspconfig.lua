-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "clangd", "jsonls", "cmake", "pylsp", "emmet_language_server" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  if vim.lsp.config then
    -- Upgrade for nvim 0.11+
    vim.lsp.config(lsp, {
      capabilities = nvlsp.capabilities,
      on_init = nvlsp.on_init
    })
    vim.lsp.enable(lsp)
  else
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end

if vim.lsp.config then
  -- Upgrade for nvim 0.11+
  vim.lsp.config("dartls", {
    -- on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "dart", "language-server", "--protocol=lsp" },
  })
  vim.lsp.enable("dartls")
else
  lspconfig.dartls.setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "dart", "language-server", "--protocol=lsp" },
  }
end

if vim.lsp.config then
  -- Upgrade for nvim 0.11+
  vim.lsp.config("ruby_lsp", {
    -- on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,

    cmd = { "ruby-lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
    init_options = {
      formatting = "auto",
    },
    single_file_support = true,
  })
  vim.lsp.enable("ruby_lsp")
else
  lspconfig.ruby_lsp.setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,

    cmd = { "ruby-lsp" },
    filetypes = { "ruby" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
    init_options = {
      formatting = "auto",
    },
    single_file_support = true,
  })
end

if vim.lsp.config then
  -- Upgrade for nvim 0.11+
  vim.lsp.config("gopls", {
    -- on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable("gopls")
else
  lspconfig.gopls.setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end
