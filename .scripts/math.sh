#!/bin/bash

# Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH
echo "\$\$" > ~/math.tex
xterm -geometry 80X10  -e nvim ~/math.tex "+call cursor(1,3)"
cat ~/math.tex|xclip -r -selection clipboard 
# -r: when  the  last  character of the selection is a newline character, remove it. Newline characters that are not the last character in the selection are not affected. If the selection does not end with a newline character
