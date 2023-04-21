local opt = vim.opt
local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- g.netrw_browse_split = 0
-- g.netrw_banner = 0
-- g.netrw_winsize = 255

opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.copyindent = true
opt.smarttab = true
opt.termguicolors = true
opt.breakindent = true
opt.hlsearch = true
opt.ignorecase = true
opt.updatetime = 50
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize"

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

require('plugins')
require('mappings')

vim.cmd 'colorscheme tokyonight-moon'
vim.cmd ':hi normal guibg=000000'
