#!/bin/sh
i3-msg "workspace 2:_code_; append_layout ~/.config/i3/code2.json"

# And finally we fill the containers with the programs they had
(urxvt -e $SHELL -c 'cd ~/dev/;$SHELL -i' &)
sleep .01
(urxvt -e $SHELL -c 'cd ~/dev/;$SHELL -i' &)
sleep .09
(urxvt -e $SHELL -c 'cd ~/dev/ && todo.sh pv @web;$SHELL -i' &)


