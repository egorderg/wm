#!/bin/bash

DISABLED=$(systemctl status nftables.service | grep inactive)
if [[ $DISABLED ]]; then
  printf "󱜢"
else
  printf "󱨑"
fi
