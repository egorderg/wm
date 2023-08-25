{ config, pkgs, lib, ... }:
{
	services.swayidle = {
		enable = true;
		systemdTarget = "hyprland-session.target";
		timeouts = [
			{
				timeout = 300;
				command = "${pkgs.swaylock}/bin/swaylock -f";
			}
			{
				timeout = 600;
				command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
				resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
			}
		];
		events = [
			{
				event = "before-sleep";
				command = "swaylock -f";
			}
		];
	};
}