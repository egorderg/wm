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
			wallpaper = "egor/assets/wallpaper.jpg";
			lock = "egor/assets/lock.jpg";
			terminal = "foot";
			menu = "desktop-menu-all";
		})

		../../programs/vscode
		../../programs/lf
		../../programs/monitor
		../../programs/qmv
		../../programs/foot.nix
		../../programs/pass.nix
		../../programs/cava.nix
		../../programs/mpv.nix
		../../programs/git.nix
		../../programs/neovim.nix

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
		obsidian
		gimp
		godot

		firefox
		librewolf

		wineWowPackages.stable
		winetricks
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

		DOTNET_CLI_TELEMETRY_OPTOUT = 1;
	};

	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			
			# FZF
			fzf_configure_bindings

			# GRC
			set -U grc_plugin_execs make ifconfig ls ping ps tail traceroute mount diff

			# Vi
			fish_vi_key_bindings insert
			set fish_cursor_default block
			set fish_cursor_insert line
			set fish_cursor_replace_one underscore
			set fish_cursor_visual block
		'';
		loginShellInit = ''
			if test (tty) = /dev/tty1
				Hyprland
			end
		'';
		functions = {
			munrar = ''for file in *.rar; unrar e "$file" -p"$argv[1]"; end'';
		};
		shellAliases = {
			l = "ls -l --color=auto --group-directories-first";
			ll = "ls -lA --color=auto --group-directories-first";
			ls = "ls --color=auto";
			passgen25 = "pwgen -s -c -n 25";
			passgen18 = "pwgen -s -c -n 18";
			fastssh = "ssh -c aes128-gcm@openssh.com -o Compression=no";
		};
		plugins = [
			{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
			{ name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
			{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
		];
	};

	home.stateVersion = "23.05";
}