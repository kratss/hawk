#!/usr/bin/env fish


function parse_config
    if test -d ~/.config/hawk
        set conf_dir ~/.config
    else if test -n $XDG_CONFIG_HOME
        set conf_dir $XDG_CONFIG_HOME
    end

    for line in (cat $conf_dir/hawk/hawk.ini)
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

