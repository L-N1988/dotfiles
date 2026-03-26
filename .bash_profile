#
# ~/.bash_profile
#

# Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH
# Add python package to the PATH
export PATH="$PATH:$HOME/.local/bin/"
[[ -f ~/.bashrc ]] && . ~/.bashrc

