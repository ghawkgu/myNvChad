-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "clangd", "jsonls", "cmake", "pylsp", "emmet_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- lspconfig.pyright.setup { blabla}

lspconfig.dartls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "dart", "language-server", "--protocol=lsp" },
}

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

lspconfig.gopls.setup({
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})
