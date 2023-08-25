{ config, pkgs, lib, ... }:
{
	fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			fira-code
			fira-code-symbols

			(nerdfonts.override {
				fonts = [ "FiraCode" ];
			})
		];

		enableDefaultPackages = false;

		fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["FiraCode Nerd Font Mono" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
	};

	hardware = {
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};
	};

	programs = {
    dconf.enable = true;
		light.enable = true;
	};
	
	services = {
		# Sound
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			jack.enable = true;
			pulse.enable = true;
		};

		dbus.enable = true;

		# Required for Gnome Keyrings
		dbus.packages = [ pkgs.gcr ];
		gnome.gnome-keyring.enable = true;
	};

	security = {
    pam.services.swaylock = {};
    rtkit.enable = true;
		polkit.enable = true;
		sudo.wheelNeedsPassword = true;
  };

	xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

	environment.sessionVariables = {
		XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
	};

	environment.systemPackages = with pkgs; [
		xdg-utils
		glxinfo
		libva-utils
		vdpauinfo
		pulseaudio
		gcr
	];
}