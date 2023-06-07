local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Install plugins
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jj" },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    opts = function()
      return require "custom.configs.todo"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").lazy_load "nvim-dap"
    end,
    config = function()
      -- require "configs.dapconfig"
    end,
  },

  -- Unload plugins
  {
    "NvChad/nvterm",
    enabled = false,
  },
}

return plugins
