{ config, pkgs, lib, ... }:
{
	programs.mpv = {
		enable = true;
		config = {
			hwdec = "auto";
		};
	};
}