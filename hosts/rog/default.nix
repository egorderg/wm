# https://github.com/NixOS/nixos-hardware
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
		../../modules/desktop.nix
		../../modules/fs.nix

		../../home/desktop/gnome.nix
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

		xserver = {
			videoDrivers = ["nvidia"];
		};

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

				# sudo lshw -c display
				amdgpuBusId = "PCI:5:0:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};

		opengl = {
			extraPackages = with pkgs; [ vaapiVdpau ];
		};
	};

  environment.systemPackages = with pkgs; [
		asusctl
		sbctl
		lshw
  ];

  system.stateVersion = "23.05";
}
