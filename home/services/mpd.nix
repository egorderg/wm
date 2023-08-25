{ config, pkgs, lib, ... }:
let
	dataDir = "${config.xdg.configHome}/mpd";
in {
	home.packages = with pkgs; [
		mpc-cli
	];

	services.mpd = {
		enable = true;
		dataDir = dataDir;
		playlistDirectory = "${dataDir}/playlists";
		musicDirectory = "${config.home.homeDirectory}/Music";
		extraConfig = ''
			auto_update "yes"

			audio_output {
				type "pipewire"
				name "PipeWire Output"
			}
		'';
	};
}