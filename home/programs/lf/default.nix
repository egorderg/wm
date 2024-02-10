{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		file
		chafa
		ffmpegthumbnailer
		mediainfo
		libcdio
		poppler_utils
    lf
	];

	xdg.configFile."lf/previewer.sh".source = pkgs.writeShellScript "previewer.sh" (builtins.readFile ./previewer.sh);
	xdg.configFile."lf/lfrc".source = ./lfrc;
	xdg.configFile."lf/icons".source = ./icons;
	xdg.configFile."lf/colors".source = ./colors;
}
