#!/bin/bash

DISABLED=$(systemctl status firewall.service | grep inactive)
if [[ $DISABLED ]]; then
  printf "󱜢"
else
  printf "󱨑"
fi
