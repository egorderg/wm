#!/usr/bin/env bash

PWD=$(pwd)
cp -f /etc/nixos/hardware-configuration.nix "$PWD"/hosts/rog/

nixos-rebuild switch --flake path:$(pwd)#rog
