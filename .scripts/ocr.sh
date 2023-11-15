#!/bin/sh -e

selection=$(hacksaw -f "-i %i -g %g")
shotgun $selection ocrfig
tesseract -l chi_sim+eng ocrfig ocroutput --dpi 150
cat ocroutput.txt  | python /home/liuning/.scripts/ocr_clean.py | xclip -sel clip
rm ocrfig ocroutput.txt

