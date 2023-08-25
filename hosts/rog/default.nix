{ config, pkgs, ... }:
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

	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
		};
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			enableCryptodisk = true;
			theme = pkgs.stdenv.mkDerivation {
				pname = "grub-theme";
				version = "1.0";
				src = pkgs.fetchFromGitHub {
					owner = "HenriqueLopes42";
					repo = "themeGrub.CyberEXS";
					rev = "b20991c1385338dc0fc407d22c4ceba89fbc4618";
					hash = "sha256-/cXdzJwaqRuell63GiNvTRxESm9ub/YAX0/OsdWBbsY=";
				};
				installPhase = "cp -r ./ $out";
			};
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
  ];

  system.stateVersion = "23.05";
}