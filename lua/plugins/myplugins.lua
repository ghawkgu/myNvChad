local overrides = require("configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     -- format & linting
  --     {
  --       -- "jose-elias-alvarez/null-ls.nvim",
  --       "nvimtools/none-ls.nvim",
  --       config = function()
  --         require "configs.null-ls"
  --       end,
  --     },
  --   },
  --   config = function()
  --     -- require "nvchad.configs.lspconfig"
  --     require "configs.lspconfig"
  --   end, -- Override to setup mason-lspconfig
  -- },

  -- override plugin configs
  {
    "tpope/vim-rsi",
    lazy = false, -- Disables lazy loading completely
    priority = 1000, -- Force loads it before normal plugins
  },

  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, overrides.telescope)
    end,
  },

  {
    "ibhagwan/fzf-lua",
    event = "BufEnter",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
      },

      previewers = {
        builtin = {
          limit_b = 1024 * 1024 * 20
        }
      },
    }
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "andymass/vim-matchup",
    lazy = false,
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        default_mappings = false,
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"},
  },

  {
    "tpope/vim-rails",
    lazy = false,
  },

  -- {
  --   "tpope/vim-surround",
  -- },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    "junegunn/vim-easy-align",
    -- event = "BufEnter",
    lazy = false,
    config = function()
      -- vnoremap <silent> <Enter> :EasyAlign<cr>
      vim.keymap.set('v', '<Enter>', ':EasyAlign<CR>')
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      vim.cmd("Lazy load markdown-preview.nvim")
      vim.fn["mkdp#util#install"]()
      -- local app_dir = plugin.dir .. "/app"
      -- vim.fn.system("cd " .. app_dir .. " && npm install mermaid@latest && cp node_modules/mermaid/dist/mermaid.min.js _static/mermaid.min.js")

      -- 1. Run the standard app initialization via npm or yarn
      vim.fn.system({ "npm", "install" })

      -- 2. Determine the path to the internal static asset directory
      local static_dir = plugin.dir .. "/app/_static/"
      local target_file = static_dir .. "mermaid.min.js"

      -- 3. Fetch the absolute latest stable version from the jsDelivr CDN
      local cdn_url = "https://cdn.jsdelivr.net/npm/mermaid@latest/dist/mermaid.min.js"

      -- 4. Download and overwrite the outdated file seamlessly
      if vim.fn.executable("curl") == 1 then
        vim.fn.system({ "curl", "-sL", cdn_url, "-o", target_file })
      elseif vim.fn.executable("wget") == 1 then
        vim.fn.system({ "wget", "-q", cdn_url, "-O", target_file })
      end
    end,
  },

  -- config-local enables project-specific config
  -- For example, to add the clangd config to .cland.lua to project root dir.
  --
  -- local lspconfig = require "lspconfig"
  --
  -- lspconfig.clangd.setup {
  --   cmd = {
  --     "clangd",
  --     "--pretty",
  --     "--header-insertion=iwyu",
  --     "--background-index",
  --     "--suggest-missing-includes",
  --     "--query-driver=/usr/bin/arm-none-eabi-gcc",
  --     "-j=40",
  --     "--pch-storage=memory",
  --     "--clang-tidy",
  --     "--compile-commands-dir=./build/",
  --   },
  --   filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  -- }
  {
    "klen/nvim-config-local",
    lazy = false,
    config = function()
      require("config-local").setup {
        -- Default options (optional)

        -- Config file patterns to load (lua supported)
        config_files = { ".clangd.lua", ".nvim.lua", ".nvimrc", ".exrc" },

        -- Where the plugin keeps files data
        hashfile = vim.fn.stdpath("data") .. "/config-local",

        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
        silent = false, -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = false, -- Lookup config files in parent directories
      }
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  -- To use a extras plugin
  -- { import = "configs.extras.symbols-outline", },

  -- To enable the blink.cmp, which is under experiment
  -- { import = "nvchad.blink.lazyspec" },
}

return plugins
