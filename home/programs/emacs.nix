{ config, pkgs, lib, ...}:
{
	programs.emacs = {
		enable = true;
		package = pkgs.emacs29-gtk3;
	};

	home.packages = with pkgs; [
		gopls
		delve
	];
}