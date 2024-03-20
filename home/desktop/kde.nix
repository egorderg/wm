{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;

  services.xserver.displayManager = {
    defaultSession = "plasmax11";
    sddm = {
      enable = true;
      wayland.enable = false;
    };
  };

  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
    kate
  ];
}
