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
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- Lua
    "lua-language-server",
    "stylua",

    -- Web Development
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
  },
}

M.nvimtree = {
  filters = {
    dotfiles = false,
    -- custom = { "node_modules" },
  },
  git = {
    enable = true,
  },
  view = {
    signcolumn = "yes",
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  defaults = {
    mappings = {
      n = {
        ["<leader>sh"] = "select_vertical",
        ["<leader>sv"] = "select_horizontal",
      },
    },
  },
}

return M
