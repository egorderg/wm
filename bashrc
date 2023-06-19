#!/bin/bash

# Env
export BEMENU_OPTS="-W 0.5 -H 25 -M 20 -l 20 --fn \"Fira Code\" -B 1 --bdr #4E5173 --tf #61AFEF --hf #61AFEF --nb #1A1B26 --tb #1A1B26 --ab #1A1B26 --fb #1A1B26 --hb #1A1B26"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_MUSIC_DIR=$HOME/Music

# Misc
alias freecaches='sync;echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias pkg_count='pacman -Q | wc -l'

# Files
alias lf='~/.config/lf/run.sh'
alias ll='ls -l --color=auto --group-directories-first'
alias lsa='ls -lA --color=auto --group-directories-first'

# Trash
alias tt='trash-put'
alias tls='echo q | trash-list | sort -k2,3'
alias tres='trash-restore'
alias tempty='trash-empty'

# Password Gen
alias passgen='pwgen -s -c -n 25'
alias passgen18='pwgen -s -c -n 18'

# Archiving
alias arar="unrar x"
alias azip="unzip"
alias a7z="7z x"

# FZF
alias fmake="cat Makefile | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split(\$1,A,/ /);for(i in A)print A[i]}' | fzf | xargs -r make"
alias fproj="cd \$(find ~/Documents/dev/* -type d -prune | fzf)"

#SSH
alias fastssh="ssh -c aes128-gcm@openssh.com -o Compression=no"

# VPN
vpnor() {
  sudo pkill openvpn
  sudo -b openvpn "/etc/openvpn/client/random.ovpn"
}

# ffmpeg
ffmpeg-thumbnails() {
  for i in *.mkv; do
    ffmpeg -i "$i" -ss 00:10:00.000 -vf 'scale=200:200:force_original_aspect_ratio=decrease' -vframes 1 "${i%.*}.png";
  done
}

outback-metadata() {
  for i in *.mkv; do
    file="${i%.*}.meta"
    mediainfo --Inform="General;%Duration%" "$i" > "$file"
    mediainfo --Inform="Audio;%Language%," "$i" >> "$file"
    mediainfo --Inform="Text;%Language%," "$i" >> "$file"
  done
}
