#!/bin/zsh
rofi -combi-modi drun,run -show combi -run-shell-command '{terminal} -e \\" {cmd}; read -n 1 -s\\"'