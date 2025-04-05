#
# ~/.bash RC
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='la -l'
alias grep='grep --color=auto'
alias v='vim'
alias vi='vim'
alias vf='vim $(fzf)'
alias nv='nvim'
alias p='ipython --pylab'
alias ju='julia'

PS1='[\u@\h \W]\$ '
export NEMU_HOME=/home/liuning/ics2022/nemu
export AM_HOME=/home/liuning/ics2022/abstract-machine
export ISA=riscv32
## Add TeX Live to the PATH, MANPATH, INFOPATH
# export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
# export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH
# export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH

alias of8="source /opt/OpenFOAM/OpenFOAM-8/etc/bashrc"
alias of1916="source ~/openfoam-v1912/etc/bashrc"
source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash
source /etc/profile
