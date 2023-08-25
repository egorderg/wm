{ config, lib, ... }:
{
	networking = {
		firewall.enable = true;

		networkmanager = {
			enable = true;
			dns = "systemd-resolved";
			wifi.powersave = true;
		};
	};

	services = {
		avahi = {
      enable = true;
      nssmdns = true;
    };
	};

	# Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}