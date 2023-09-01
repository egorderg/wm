{ config, lib, pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		extraLuaConfig = ''
		 	local g = vim.g
			local opt = vim.opt	
			local kset = vim.keymap.set

			opt.clipboard = "unnamedplus"
			opt.number = true
			opt.relativenumber = true

			opt.expandtab = true
			opt.shiftwidth = 2
			opt.smartindent = true
			opt.tabstop = 2
			opt.softtabstop = 2

			opt.swapfile = false
			opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize"

			g.mapleader = " "

			kset("n", "<leader>q", "<cmd>q<CR>")
			kset("n", "<leader>sh", "<cmd>vsplit<CR>")
			kset("n", "<leader>sv", "<cmd>split<CR>")
			kset("n", "<leader>ww", "<cmd>w<CR>")
			kset("n", "<leader>wa", "<cmd>wa<CR>")
			kset("n", "<leader>bc", "<cmd>b#|bd#<CR>")
		'';
	};
}