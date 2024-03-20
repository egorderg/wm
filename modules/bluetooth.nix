{ config, pkgs, lib, ... }:
{
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		package = pkgs.bluez5-experimental;
	};
}
