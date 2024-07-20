# Hawk
Easily find and launch files from the desktop. Dmenu for your files.

![Screenshot](docs/screenshot1.png) 

# Features
- Find files fast with `fzf`
- Search easily with fuzzy matching
- Preview files including thumbnails
- Lightweight

# Integration and Configuration
- Launches files with `xdg-open` `rifle` or your own script
- Integrates easily into Sway or your favorite wm
- Supports XDG base directory specification
- Configures with a simple ini file

# Installation
- Place hawk.fish and hawk-preview.fish in your  `~/.local/bin/`
- Place hawk.ini in `~/.config/hawk/` or `XDG_CONFIG_HOME/hawk/`\
## Sway Integration
- Insert the following line to your sway config:\
    `bindsym $mod+Shift+d $hawk`
- Add `include hawk-sway` to your sway config and place `hawk-sway` in ~/.config/sway/\
## Dependencies
- Required: `fish` `fzf`
- Optional: `chafa` `ffmpeg` `odt2txt` `pdftotext`

