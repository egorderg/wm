{ config, pkgs, lib, ... }:
{
  home.file.".ideavimrc".source = ./ideavimrc;

  home.packages = with pkgs; [
		jetbrains.idea-ultimate
		jetbrains.rider
		jetbrains.gateway
  ];
}
