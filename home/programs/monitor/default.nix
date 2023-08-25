{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		nvtop
	];

	programs.btop = {
		enable = true;
		settings = {
			color_theme = "${config.home.homeDirectory}/.config/btop/themes/tokyo-night.theme";
			theme_background = false;
			truecolor = true;
			vim_keys = true;
			rounded_corners = true;
		};
	};

	xdg.configFile."btop/themes/tokyo-night.theme".source = ./tokyo-night.theme;
}
