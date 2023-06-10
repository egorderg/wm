-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- Load default config
local servers = { "html", "cssls", "tsserver", "gopls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gdscript.setup {
  cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
  on_attach = on_attach,
  capabilities = capabilities,
}
