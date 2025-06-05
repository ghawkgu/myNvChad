local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",

    "cpp",
    "make",
    "cmake",

    "dart",
    "go",
    "ruby",
    "python",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  matchup = {
    enable = true, -- mandatory
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "emmet-ls",
    "json-lsp",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "cmake-language-server",

    -- python
    "autopep8",
    "python-lsp-server",

    -- golang
    "gofumpt",
    "gopls",

    -- ruby
    "ruby-lsp",
    "rubyfmt",
  },
}

M.telescope = {
  selection_caret = "> ",
  -- selection_caret = "|> ",
  entry_prefix = "    ",
  -- borderchars = {
  --   prompt  = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
  --   results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
  --   preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  -- },
  winblend = 0,
  border = true,
  -- borderchars = {
  --   prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --   results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  -- },
}

local function nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- open as vsplit on current node
  local function open_vsplit()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file as vsplit
      api.node.open.vertical()
    end
  end

  -- use all default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  vim.keymap.del('n', 's', { buffer = bufnr })
  vim.keymap.set("n", "s", open_vsplit, opts("Vsplit"))
end

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  view = {
    adaptive_size = false,
    side = "left",
    width = 40, -- 30 by default
    preserve_window_proportions = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  on_attach = nvim_tree_on_attach
}

M.gitsigns = {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)
  end
}

return M
