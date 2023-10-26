{ config, pkgs, lib, ... }:
{
  home.file.".ideavimrc".source = ./ideavimrc;

  home.packages = with pkgs; [
		jetbrains.rider
		jetbrains.gateway
  ];
}
