local api = vim.api
local g = vim.g

-- Leader Key
api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "

-- Standard
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", {})
vim.keymap.set("n", "<leader>ww", "<cmd>w<cr>", {})
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", {})
vim.keymap.set("n", "<leader>ch", "<cmd>checkhealth<cr>", {})
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", {})
vim.keymap.set("v", "<leader>p", "\"ap", {})
vim.keymap.set("n", "<leader>p", "\"ap", {})
vim.keymap.set("v", "<leader>d", "\"ad", {})
vim.keymap.set("v", "<leader>y", "\"ay", {})

-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fF", function ()
	builtin.find_files { hidden = true, no_ignore = true }
end, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fR", builtin.registers, {})
vim.keymap.set("n", "<leader>fc", builtin.commands, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fr", builtin.resume, {})

-- Split
vim.keymap.set('n', '<leader>sh', '<cmd>vsplit<cr>', {})
vim.keymap.set('n', '<leader>sv', '<cmd>split<cr>', {})

-- Buffers
vim.keymap.set("n", "<leader>bc", "<cmd>bp|bd #<cr>", {})
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", {})

-- Terminal
local function open_term()
	if vim.fn.executable('zsh') == 1 then
		vim.cmd('e term://zsh')
	else
		vim.cmd('e term://bash')
	end
end

vim.keymap.set("n", "<leader>tt", open_term, {})
vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], {})

