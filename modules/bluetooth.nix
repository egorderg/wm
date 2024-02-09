{ config, pkgs, lib, ... }:
{
	hardware.bluetooth = {
		enable = true;
		package = pkgs.bluez5-experimental;
	};

  services.blueman = {
    enable = true; 
  };
}
