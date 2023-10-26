#!/bin/bash

VPN=$(ip addr | grep wg0)
if [[ $VPN ]]; then
  printf "󰒄"
else
  printf "󰅛"
fi
