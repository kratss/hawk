#!/usr/bin/env fish

nohup xdg-open (fzf --walker=file,dir --preview "hawk-preview.fish {}") & 
sleep 0 


