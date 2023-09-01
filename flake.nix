{
	description = "egors nixos and home-manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		lanzaboote.url = "github:nix-community/lanzaboote";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, home-manager, lanzaboote, hyprland, ... }:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				rog = lib.nixosSystem rec {
					inherit system;
					specialArgs = { inherit hyprland; };
					modules = [
						./hosts/rog
						lanzaboote.nixosModules.lanzaboote
						hyprland.nixosModules.default
						home-manager.nixosModules.home-manager
						{
							home-manager.users.egor = import ./home/.users/egor;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.extraSpecialArgs = specialArgs;
						}
					];
				};
			};
		};
}
