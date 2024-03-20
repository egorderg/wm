{ config, pkgs, lib, ... }:
{
  programs.librewolf = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
        }; 
      };
    };
  };
}
