{ hyprland, pkgs, lib, ... }:
let
	all = pkgs.writeShellScriptBin "desktop-menu-all" (builtins.readFile ./menu/all);
	music = pkgs.writeShellScriptBin "desktop-menu-music" (builtins.readFile ./menu/music);
	pass = pkgs.writeShellScriptBin "desktop-menu-pass" (builtins.readFile ./menu/pass);
	settings = pkgs.writeShellScriptBin "desktop-menu-settings" (builtins.readFile ./menu/settings);
	system = pkgs.writeShellScriptBin "desktop-menu-system" (builtins.readFile ./menu/system);
	video = pkgs.writeShellScriptBin "desktop-menu-video" (builtins.readFile ./menu/video);
in {
	imports = [
		(import ../../desktop/hyprland {
			wallpaper = "egor/wallpaper.jpeg";
			lock = "egor/lock.jpg";
			terminal = "foot";
			menu = "desktop-menu-all";
		})

		../../programs/vscode
		../../programs/lf
		../../programs/monitor
		../../programs/qmv
		../../programs/foot.nix
		../../programs/neofetch.nix
		../../programs/pass.nix
		../../programs/cava.nix
		../../programs/mpv.nix
		../../programs/git.nix

		../../services/gpg.nix
		../../services/mpd.nix
	];

	home.packages = with pkgs; [
		all
		music
		pass
		settings
		video
		system

		bluetuith
		pavucontrol
		imagemagick
		yt-dlp
		megacmd
		pwgen
		ncmpcpp
		imv
		bat
		trash-cli

		firefox
		librewolf
	];

	home.sessionVariables = {
		BROWSER = "librewolf";
		EDITOR = "nvim";
		
		# GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = "1";
		__GL_VRR_ALLOWED = "0";
		# WLR_RENDERER = "vulkan";

		LIBVA_DRIVER_NAME = "radeonsi";
		VDPAU_DRIVER = "radeonsi";
	};
 
 	programs.bash = {
		enable = true;
		profileExtra = ''
			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
				Hyprland
			fi
		'';
	};

	home.stateVersion = "23.05";
}
