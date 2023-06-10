---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- General
    ["<C-s>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>b"] = "",
    ["<leader>/"] = "",

    -- Telescope
    ["<leader>pt"] = "",
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>ma"] = "",

    -- NvimTree
    ["<C-n>"] = "",
    ["<leader>e"] = "",

    -- Gitsigns
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    ["<leader>td"] = "",
    ["[c"] = "",
    ["]c"] = "",

    -- LSP
    ["gD"] = "",
    ["K"] = "",
    ["<leader>ra"] = "",
    ["<leader>ca"] = "",
    ["<leader>ls"] = "",
    ["<leader>f"] = "",
    ["<leader>q"] = "",
    ["<leader>D"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>[d"] = "",
    ["<leader>]d"] = "",
  },
  v = {
    -- General
    ["<leader>/"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- Window
    ["<leader>qq"] = { "<cmd>q<CR>", "Close window" },
    ["<leader>qa"] = { "<cmd>qa<CR>", "Close all window" },
    ["<leader>qs"] = {
      function ()
        vim.cmd("mksession! " .. vim.fs.normalize(vim.fn.getcwd() .. "/session.vim"))
        vim.cmd("qa")
      end, "Close all windows and save session"
    },
    ["<leader>sh"] = { "<cmd>vsplit<CR>", "Split horizontal" },
    ["<leader>sv"] = { "<cmd>split<CR>", "Split vertical" },

    -- Save
    ["<leader>ww"] = { "<cmd>w<CR>", "Save file" },
    ["<leader>wa"] = { "<cmd>wa<CR>", "Save all fihe" },

    -- Buffer
    ["<leader>bn"] = { "<cmd>enew<CR>", "New buffer" },
    ["<leader>bc"] = { "<cmd>Bdelete<CR>", "Close buffer" },
    ["<leader>bo"] = { "<cmd>%bp|e#|bd#<CR>", "Close other buffers" },
  },
  v = {
    ["<"] = { "<gv", "Oudent Lines" },
    [">"] = { ">gv", "Indent Lines" },
  },
}

M.nvimtree = {
  n = {
    -- ["<leader>et"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- ["<leader>ee"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
    ["<leader>ee"] = { "<cmd> NvimTreeToggle <CR>", "Focus nvimtree" },
  }
}

M.telescope = {
  n = {
    ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "Commands" },
    ["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Marks" },
    ["<leader>ft"] = { "<cmd> TodoTelescope <CR>", "Todos" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>fd"] = { "<cmd> Telescope diagnostics <CR>", "Diagnostics" },
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "LSP document symbols" },
    ["<leader>fS"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "LSP workspace symbols" },
    ["gd"] = {
      "<cmd> Telescope lsp_definitions <CR>",
      "LSP definition",
    },
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["gi"] = {
      "<cmd> Telescope lsp_implementations <CR>",
      "LSP implementation",
    },
    ["gn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },
    ["ga"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["gr"] = {
      "<cmd> Telescope lsp_references <CR>",
      "LSP references",
    },
    ["ge"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<leader>gf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },
}

return M
