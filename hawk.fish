#!/usr/bin/env fish

#swaymsg floating_maximum_size 300x300
nohup xdg-open (fzf --walker=file,dir --preview "$PWD/hawk-preview.fish {}") & 
sleep 0 


