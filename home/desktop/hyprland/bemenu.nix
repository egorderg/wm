{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		bemenu
	];

	home.sessionVariables = {
		DMENU = "bemenu -i";
		BEMENU_OPTS = ''-W 0.5 -H 25 -M 20 -l 20 --fn \"Fira Code\" -B 1 --bdr #4E5173 --tf #61AFEF --hf #61AFEF --nb #1A1B26 --tb #1A1B26 --ab #1A1B26 --fb #1A1B26 --hb #1A1B26'';
	};
}
