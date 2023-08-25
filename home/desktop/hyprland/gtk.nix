{ config, pkgs, lib, ... }:
{
	gtk = {
		enable = true;
		theme = {
			package = pkgs.palenight-theme;
			name = "palenight";
		};
		cursorTheme = {
			package = pkgs.catppuccin-cursors.mochaDark;
			name = "Catppuccin-Mocha-Dark-Cursors";
		};
	};
}