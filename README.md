## FileSystems

Example of a `fs.nix` configuration
```nix
{ config, pkgs, ... }:
{
	fileSystems."/mnt/Example" = {
		device = "//123.123.1.2/Example";	
		fsType = "cifs";
		options = [ "credentials=/root/nixos/nas-secrets,uid=${toString config.users.users.egor.uid},noauto" ];
	};

	environment.systemPackages = with pkgs; [
		cifs-utils
	];
}

```

## SecureBoot
https://nixos.wiki/wiki/Secure_Boot