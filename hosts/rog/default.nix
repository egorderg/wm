{ config, pkgs, lib, ... }:
{
  imports = [
		./hardware-configuration.nix
		../../modules/nix.nix
		../../modules/core.nix
		../../modules/bluetooth.nix
		../../modules/security.nix
		../../modules/network.nix
		../../modules/vpn.nix
		../../modules/fs.nix
		../../modules/desktop.nix
	];

  networking.hostName = "rog";

	boot = {
		blacklistedKernelModules = [ "nouveau" ];
		bootspec.enable = true;
		loader = {
			efi = {
				# UEFI Support
				canTouchEfiVariables = true;
			};
			systemd-boot = {
				enable = lib.mkForce false; # Replaced by Lanzaboote
				editor = false;
			};
		};
		lanzaboote = {
			enable = true;
			pkiBundle = "/etc/secureboot";
		};
	};

	services = {
		asusd.enable = true;
		xserver.videoDrivers = ["nvidia"];

		printing = {
			enable = true;
			drivers = [pkgs.epson-escpr2];
		};
	};

	hardware = {
		nvidia = {
			modesetting.enable = true;
			nvidiaSettings = true;
			open = false;
			package = config.boot.kernelPackages.nvidiaPackages.latest;

			prime = {
				offload = {
					enable = true;
					enableOffloadCmd = true;
				};

				amdgpuBusId = "PCI:5:0:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};

		opengl = {
			extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libvdpau-va-gl vaapiVdpau ];
		};
	};

  environment.systemPackages = with pkgs; [
		asusctl
		sbctl
  ];

  system.stateVersion = "23.05";
}