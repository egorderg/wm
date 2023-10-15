{ config, lib, ... }:
{
	networking = {
		networkmanager = {
			enable = true;
			dns = "systemd-resolved";
			wifi.powersave = true;
		};
	};

	services = {
    resolved.enable = true;

		avahi = {
      enable = true;
      nssmdns = true;
    };
	};

	# Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
