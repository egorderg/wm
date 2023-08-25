#!/bin/bash

VPN=$(ip addr | grep tun0)
if [[ $VPN ]]; then
  printf "󰒄"
else
  printf "󰅛"
fi
