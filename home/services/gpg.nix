{ config, pkgs, lib, ... }:
{
	programs.gpg = {
		enable = true;
		mutableTrust = true;
		mutableKeys = true;
	};

	services.gpg-agent = {
		enable = true;
		pinentryPackage = pkgs.pinentry-gnome3;
	};
}
