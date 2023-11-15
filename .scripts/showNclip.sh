#!/bin/sh -e

selection=$(hacksaw -f "-i %i -g %g")
shotgun $selection - | xclip -t 'image/png' -selection clipboard
shotgun $selection shotfig
mv shotfig shotfig.png
feh shotfig.png
