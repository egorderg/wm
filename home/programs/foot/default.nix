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
			pad = "0x0";
			size = "13";
		})
	];

	programs.foot = {
		enable = true;
	};
}
