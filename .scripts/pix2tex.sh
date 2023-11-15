#!/bin/sh
# cause the script to exit immediately if any command in the script fails
set -e

# screenshot tool
selection=$(hacksaw -f "-i %i -g %g")
shotgun $selection ocrfig
mv ocrfig ocrfig.png

# ocr to math latex
pix2tex ocrfig.png | sed 's/.*://' | tr -d '\n' |xclip -selection clipboard

# notification
dunstify "pix2tex ocr" "finished" --timeout=1200
