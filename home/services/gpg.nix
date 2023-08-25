{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		pinentry-gnome
	];

	programs.gpg = {
		enable = true;
		mutableTrust = true;
		mutableKeys = true;
	};

	services.gpg-agent = {
		enable = true;
		pinentryFlavor = "gnome3";
	};
}