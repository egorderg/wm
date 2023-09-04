{ theme }:
{ config, pkgs, lib, ... }:
{
	programs.waybar = {
		enable = true;
		package = pkgs.waybar.overrideAttrs (oldAttrs: {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		});
		systemd = {
			enable = false;
		};
	};

	xdg.configFile."waybar/config.jsonc".source = ./themes + "/${theme}.jsonc";
	xdg.configFile."waybar/style.css".source = ./themes + "/${theme}.css";
	xdg.configFile."waybar/vpn".source = pkgs.writeShellScript "vpn.sh" (builtins.readFile ./vpn.sh);
	xdg.configFile."waybar/firewall".source = pkgs.writeShellScript "firewall.sh" (builtins.readFile ./firewall.sh);
	xdg.configFile."waybar/song".source = pkgs.writeShellScript "song.sh" (builtins.readFile ./song.sh);
}
