{ pkgs, lib, ... }:
{
	users = {
		users.egor = {
			uid = 1000;
			isNormalUser = true;
			home = "/home/egor";
			description = "Egor";
			extraGroups = [ "networkmanager" "wheel" "video" "share" ];
		};
	};

	time.timeZone = lib.mkDefault "Europe/Berlin";
	console.keyMap = "us";

	i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];
  };

	environment.systemPackages = with pkgs; [
		git
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