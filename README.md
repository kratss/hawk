Easily find and launch files from the desktop. Dmenu for your files.

![Screenshot](docs/screenshot1.png) 

# Features
- Finds files fast with `fzf`
- Fuzzy matching
- Launches files with `xdg-open` `rifle` or your custom script
- Opens in a terminal window, so Hawk always matches your theming
- Preview files in pop-up window
- Integrate easily into sway or your favorite wm

# Instructions
**Sway Integration**
* Copy `hawk.fish` and `hawk-preview.fish` to your `~/.local/bin`

* Insert the following lines to your sway config :
`set $hawk exec foot -T "Hawk" ~/.local/bin/hawk.fish`
`for_window [title="Hawk"] floating enable`
`bindsym $mod+Shift+d $hawk`

**Dependencies**
`fish fzf pdftotext`
