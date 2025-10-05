vim.g.maplocalleader = ","

-- Run this command to start repl server
-- $ sbcl --eval '(ql:quickload :swank)'  --eval '(swank:create-server :dont-close t)'

return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "lisp", "scheme" }, -- load only for these filetypes
    lazy = true,
    init = function()
      -- Optional debug
      -- vim.g["conjure#debug"] = true
      -- Conjure config
    end,
    config = function()
      -- Set buffer-local <LocalLeader> and keymaps for Conjure buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "clojure", "fennel", "lisp", "scheme" },
        callback = function()
          -- Buffer-local <LocalLeader>
          -- vim.b.maplocalleader = "\\"
          vim.b.maplocalleader = ","

          -- Conjure-specific keymaps
          local opts = { noremap = true, silent = true, buffer = true }
          local keymap = vim.keymap.set
          keymap("n", "<LocalLeader>cc", "<cmd>ConjureConnect<CR>", opts)
          keymap("n", "<LocalLeader>rr", "<cmd>ConjureEvalRootForm<CR>", opts)
          keymap("v", "<LocalLeader>ee", "<cmd>ConjureEval<CR>", opts)


          -- vim.g["conjure#completion#omnifunc"] = "ConjureOmniFunc"
          -- vim.opt_local.omnifunc = "conjure#completion#omnifunc"
        end,
      })

      -- Disable the auto closing single quote
      local npairs = require("nvim-autopairs")
      local cond = require('nvim-autopairs.conds')
      npairs.get_rules("'")[1].not_filetypes = { "clojure", "fennel", "lisp", "scheme" }
      npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))
    end,

    -- Optional cmp-conjure integration
    dependencies = {
      "PaterJason/cmp-conjure",
      "windwp/nvim-autopairs",
    },
  },
  {
    "gpanders/nvim-parinfer",
    ft = { "lisp", "clojure", "fennel", "janet", "scheme" },
    config = function()
      vim.g.parinfer_mode = "smart"
    end,
  },
  {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },
}
