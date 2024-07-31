#!/usr/bin/env fish
#TODO: Use argparse --stop-noopt to support in-line arguments for subcommands
function parse_config
    if test -d ~/.config/hawk
        set conf_dir ~/.config
    else if test -n "$XDG_CONFIG_HOME"
        set conf_dir $XDG_CONFIG_HOME
    end

    for line in (cat $conf_dir/hawk/hawk.ini)
        string trim -q $line
        if echo $line | grep -q "^#"; or test -z $line
            continue
        else if test $line = "[hawk]"
            set section hawk
        else if test $line = "[preview]"
            set section preview
        else if test $line = "[fzf]"
            set section fzf
        else if test $section = hawk
            set -a args_hawk "--$line"
        else if test $section = preview
            set -a args_preview "--$line"
        else if test $section = fzf
            set -a args_fzf "--$line"
        end
    end
end


#Parse hawk.ini and in-line args
set args_hawk 
set args_preview
set args_fzf 
parse_config
set -a args_hawk $argv
argparse  'l/launcher=' 't/thumb_size=' -- $args_hawk
if test -n "$_flag_thumb_size" 
    set -a args_preview "--thumb_size=$_flag_thumb_size"
end


# Launch search
if test "$_flag_launcher" = "xdg-open"
    nohup xdg-open \
        (fzf $args_fzf --preview "hawk-preview.fish $args_preview {}") \
        2> /dev/null  &
    sleep 0

else if test -n "$_flag_launcher"
    $_flag_launcher (fzf $args_fzf --preview "hawk-preview.fish $args_preview {}")

else
    nohup xdg-open \
        (fzf $args_fzf --preview "hawk-preview.fish  $args_preview {}") \
        2> /dev/null &
    sleep 0 
end

