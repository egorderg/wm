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
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = {
        border = "rounded",
        width = 50,
        height = 50,
      },
    },
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

M.cmp = {
  sources = {
    name = "nvim_lsp",
    priority = 10,
    keyword_length = 6,
    group_index = 1,
    max_item_count = 15,
  },
  performance = {
    trigger_debounce_time = 500,
    throttle = 550,
    fetching_timeout = 80,
  },
}

return M
