{ config, pkgs, lib, ... }:
{
	imports = [
		(import ./config.nix {
			name = "foot.ini";
			title = "foot";
			pad = "32x16";
			size = "14";
		})
		(import ./config.nix {
			name = "foot-code.ini";
			title = "foot-code";
			pad = "22x20";
			size = "13";
		})
	];

	programs.foot = {
		enable = true;
	};
}
