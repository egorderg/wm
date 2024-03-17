local g = vim.g
local opt = vim.opt

if vim.g.neovide then
	opt.guifont = "FiraCode Nerd Font Ret:h10.2"
	opt.linespace = 2
	g.neovide_cursor_animation_length = 0.05
	g.neovide_cursor_trail_size = 0.1
end

g.netrw_banner = 0

opt.termguicolors = false

opt.number = true
opt.relativenumber = true

opt.autoindent = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.hlsearch = true
opt.ignorecase = true
opt.breakindent = true

require("plugins")

vim.keymap.set("n", "<C-r>", "<nop>")
vim.keymap.set("n", "G", "<nop>")
vim.keymap.set("n", "$", "<nop>")

vim.keymap.set("n", "U", "<cmd>redo<cr>")

-- Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function () vim.highlight.on_yank() end,
})

-- Theme
vim.cmd.colorscheme("catppuccin-mocha")
