# Hawk
Easily find and launch files from the desktop. Dmenu for your files.

![Screenshot](docs/screenshot1.png) 

# Features
- Finds files fast with `fzf`
- Fuzzy matching makes search easy
- Launches files with `xdg-open` `rifle` or your own script
- Opens in a terminal window, so Hawk is lightweight and always matches your desktop theme
- Previews files
- Integrate easily into Sway or your favorite wm

# Instructions
**Sway Integration**\
* Copy `hawk.fish` and `hawk-preview.fish` to your `~/.local/bin`

* Insert the following lines to your sway config:\
`set $hawk exec foot -T "Hawk" ~/.local/bin/hawk.fish`\
`for_window [title="Hawk"] floating enable`\
`bindsym $mod+Shift+d $hawk`\

**Dependencies**\
`fish fzf pdftotext`

