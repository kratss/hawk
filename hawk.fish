#!/usr/bin/env fish

function parse_config
    if test -d ~/.config/hawk
        set conf_dir ~/.config
    else if test -n "$XDG_CONFIG_HOME"
        set conf_dir $XDG_CONFIG_HOME
    end

    for line in (cat $conf_dir/hawk/hawk.ini)
        string trim -q $line
        if echo $line | grep -q "^#"
            continue
        else if test $line = "[hawk]"
            set section hawk
        else if test $line = "[fzf]"
            set section fzf
        else if test $section = hawk
            set -a args_hawk "--$line"
        else if test $section = fzf
            set -a args_fzf "--$line"
        end
    end
end

#Parse hawk.ini and in-line args
set args_hawk 
set args_fzf 
parse_config
set -a args_hawk $argv
argparse  'l/launcher=' age= -- $args_hawk
or return

echo $args_fzf

# Launch search
if test "$_flag_launcher" = "xdg-open"
    nohup xdg-open (fzf $args_fzf --preview "hawk-preview.fish {}") &
    sleep 0
else if test -n "$_flag_launcher"
    $_flag_launcher (fzf $args_fzf --preview "hawk-preview.fish {}")
else
    nohup xdg-open (fzf $args_fzf --preview "hawk-preview.fish {}") &
    sleep 0 
end



