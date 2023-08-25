{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		cava
	];

	xdg.configFile."cava/config".text = ''
	[general]
	bars = 0
	bar_width = 1
	bar_spacing = 1

	[color]
	gradient = 1
	gradient_count = 4
	gradient_color_4 = '#ff3d61'
	gradient_color_3 = '#f7768e'
	gradient_color_2 = '#ff9e64'
	gradient_color_1 = '#e0af68'

	[smoothing]
	waves = 1
	'';
}