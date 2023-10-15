{ pkgs, lib, ... }:
{
	programs = {
		fish.enable = true;
	};

	users = {
		users.egor = {
			uid = 1000;
			isNormalUser = true;
			home = "/home/egor";
			description = "Egor";
			shell = pkgs.fish;
			extraGroups = [ "networkmanager" "wheel" "video" "share" ];
		};
	};

	time.timeZone = lib.mkDefault "Europe/Berlin";
	console.keyMap = "us";

	i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];
  };

	environment.sessionVariables = {
		FZF_DEFAULT_OPTS = ''--cycle --layout=reverse --border --height=90% --no-separator --no-scrollbar --preview-window=wrap --marker=\"*\" --prompt=\">\"'';
	};

	environment.systemPackages = with pkgs; [
		git
		grc
		fd
		fzf
		ripgrep
		wget
		vim
		unrar
		unzip
		p7zip
	];
}
