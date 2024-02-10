{ name, title, pad, size }:
{ config, pkgs, lib, ... }:
{
	xdg.configFile."foot/${name}".text = ''
    [colors]
    16=ff9e64
    17=db4b4b
    background=1a1b26
    bright0=414868
    bright1=f7768e
    bright2=9ece6a
    bright3=e0af68
    bright4=7aa2f7
    bright5=bb9af7
    bright6=7dcfff
    bright7=c0caf5
    foreground=c0caf5
    regular0=15161e
    regular1=f7768e
    regular2=9ece6a
    regular3=e0af68
    regular4=7aa2f7
    regular5=bb9af7
    regular6=7dcfff
    regular7=a9b1d6
    selection-background=283457
    selection-foreground=c0caf5
    urls=73daca

    [cursor]
    color=c0caf5 c0caf5

    [main]
    app-id=${title}
    font=FiraCode Nerd Font:style=Medium:pixelsize=${size}:antialias=true:autohint=true
    pad=${pad}
    term=foot
    title=foot
  '';
}
