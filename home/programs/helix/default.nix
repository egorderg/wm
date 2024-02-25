{ config, pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ 
      omnisharp-roslyn
		  gopls
      delve
    ];
  };

  xdg.configFile."helix/config.toml".source = ./config.toml;
  xdg.configFile."helix/languages.toml".source = ./languages.toml;
}
