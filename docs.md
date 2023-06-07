## Hypr
Hyprland: https://hyprland.org/
Hyprpaper: https://github.com/hyprwm/hyprpaper
Waybar: https://github.com/Alexays/Waybar/

## Pass
https://www.passwordstore.org/

## Mega
https://github.com/meganz/MEGAcmd/blob/master/UserGuide.md

## lf
https://pkg.go.dev/github.com/gokcehan/lf

## trash-cli
https://github.com/andreafrancia/trash-cli

## fd
https://github.com/sharkdp/fd

## fzf
https://github.com/junegunn/fzf

## ripgrep
https://github.com/BurntSushi/ripgrep

## feh
https://github.com/derf/feh

## mpv
https://github.com/mpv-player/mpv

## yt-dlp
https://github.com/yt-dlp/yt-dlp

## Privacy Guides
https://www.privacyguides.org/en/tools/
https://gofoss.net/protect-your-freedom/

## UFW / Killswitch

### Important Notes
Place it in ~/.de

### Rootless status

sudo visudo -f /etc/sudoers.d/ufwstatus
`
Cmnd_Alias      UFWSTATUS = /usr/sbin/ufw status

%ufwstatus      ALL=NOPASSWD: UFWSTATUS
`

sudo groupadd -r ufwstatus
sudo gpasswd --add testuser ufwstatus

Restart/Login again

### Get Local Subnet
ip addr

sudo ufw default deny outgoing
sudo ufw default deny incoming

sudo ufw allow in to 192.168.1.0/24 -> use local subnet
sudo ufw allow out to 192.168.1.0/24 -> use local subnet

sudo ufw allow out on tun0
sudo ufw allow in on tun0

### Allow connection to vpn tunnel
sudo ufw allow out *port*/*protocol* e.g. 1234/1194, check openvpn config

sudo ufw enable
