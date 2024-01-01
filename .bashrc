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
alias matlab='ipython --profile=matlab'
alias p='ipython --pylab'
alias ju='julia'

PS1='[\u@\h \W]\$ '
export NEMU_HOME=/home/liuning/ics2022/nemu
export AM_HOME=/home/liuning/ics2022/abstract-machine
export ISA=riscv32
## Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2022/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2022/texmf-dist/doc/info:$INFOPATH
# # Add python package to the PATH
# export PATH=$PATH:$HOME/.local/bin/
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "/opt/miniconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

