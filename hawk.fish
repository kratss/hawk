#!/usr/bin/env fish

function parse_config
    for line in (cat ~/.config/hawk/hawk.ini)
        set first_char (string sub -l 1 $line)
        if test "#" = $first_char
            continue
        else
            set -a fzf_args "--$line"
        end
    end
end

set fzf_args 
parse_config
echo $fzf_args
nohup xdg-open (fzf $fzf_args --preview "hawk-preview.fish {}"  ) & 
sleep 0 

