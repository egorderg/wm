#!/bin/bash

SONG=$(mpc current)
NAME=$(basename "$SONG" ".mp3")

printf "$NAME"