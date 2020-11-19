#!/bin/bash

xbindkeys

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

exec i3 -V >> /home/adux/.config/i3/log/i3-$(date) 2>&1

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Components on the left prompt
MNML_PROMPT=(mnml_ssh mnml_pyenv mnml_status mnml_keymap)

# Components on the right prompt
MNML_RPROMPT=('mnml_cwd 2 0' mnml_git)

# Components shown on info line
MNML_INFOLN=(mnml_err mnml_jobs mnml_uhp mnml_files mnml_time)

#Magic center
MNML_MAGICENTER=(mnml_me_dirs mnml_me_ls mnml_me_git)

