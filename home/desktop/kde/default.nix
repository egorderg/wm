{ config, pkgs, lib, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6 = {
    enable = true;
    wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
  ];
}
