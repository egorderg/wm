{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  environment.systemPackages = (with pkgs; [
    papirus-icon-theme
  ]) ++ (with pkgs.gnome; [
    gnome-tweaks
    dconf-editor
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
    snapshot
  ]) ++ (with pkgs.gnome; [
    hitori #sudoku game
    iagno #go game
    atomix #puzzle game
    tali #poker game
    cheese #webcam tool
    totem # video player
    epiphany #web browser
    geary # email reader
    yelp # help
    simple-scan
    gnome-contacts
    gnome-characters
    gnome-terminal
    gnome-initial-setup
    gnome-music
    gnome-weather
    gnome-clocks
    gnome-maps
  ]);

  documentation.nixos.enable = false;

  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs ( old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        } );
      });
    })
  ];
}
