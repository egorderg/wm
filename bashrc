#!/bin/bash

# Misc
alias freecaches='sync;echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias pkg_count='pacman -Q | wc -l'

# Files
alias lf='~/.config/lf/run.sh'
alias ls='ls -l --color=auto --group-directories-first'
alias lsa='ls -lA --color=auto --group-directories-first'

# Trash
alias tt='trash-put'
alias tls='echo q | trash-list | sort -k2,3'
alias tres='trash-restore'
alias tempty='trash-empty'

# Password Gen
alias passgen='pwgen -s -c -n 25'

# Archiving
alias arar="unrar x"
alias azip="unzip"
alias a7z="7z x"

# TMUX
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    tmux new
fi
