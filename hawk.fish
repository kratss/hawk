#!/usr/bin/env fish
swaymsg resize set 1200 500
set fzf_args  "--walker=file,dir"
set -a fzf_args "--preview-label=Hawk"
set -a fzf_args "--preview-label-pos=4"
set -a fzf_args "--preview-window=right,45%,,wrap"

echo $previewargs
nohup xdg-open (fzf $fzf_args --preview "hawk-preview.fish {}"  ) & 
sleep 0 



