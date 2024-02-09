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
			waybar = "aero";
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

		../../services/gpg.nix
	  ../../services/mpd.nix

	  ./android-sdk.nix
	];

	home.packages = with pkgs; [
		all
		music
		pass
		settings
		video
		system

		pavucontrol
		imagemagick
		yt-dlp
		pwgen
		imv
		bat
		trash-cli
		gimp
		evince
		ymuse
    pyload-ng

		firefox
		librewolf

		wineWowPackages.stable
		winetricks

    helix
		tree-sitter
    omnisharp-roslyn

    jdk
    gradle
    python3
    nodejs_20
    rustup
    clang
		gnumake
    (with dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])

		(callPackage ../../programs/godot-mono.nix { })
	];

	home.sessionVariables = rec {
		BROWSER = "librewolf";

		# GBM_BACKEND = "nvidia-drm";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = "1";
		__GL_VRR_ALLOWED = "0";
		# WLR_RENDERER = "vulkan";

		LIBVA_DRIVER_NAME = "radeonsi";
		VDPAU_DRIVER = "radeonsi";

    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_7_0}";
		DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    JAVA_HOME = "${pkgs.jdk.home}";
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
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
			fastssh = "TERM=xterm ssh -c aes128-gcm@openssh.com -o Compression=yes";
			xssh = "TERM=xterm ssh";
		};
		plugins = [
			{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
			{ name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
			{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
		];
	};

	home.stateVersion = "23.05";
}
