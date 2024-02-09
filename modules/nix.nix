{ config, pkgs, lib, ... }:
{
	nix = {
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 7d";
		};

		settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
	};

	nixpkgs = {
		config.allowUnfree = true;
		config.allowUnfreePredicate = _: true;
    config.android_sdk.accept_license = true;
	};
}
