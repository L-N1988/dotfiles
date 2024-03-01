#!/usr/bin/bash
FZF="fzf"
WID=$(xdo id)
cd $HOME/OneDrive

if [ $# -eq 0 ]; then
    echo "Need more arguments to work!"
elif [ $# -eq 1 ]; then
    xdo hide $WID
    bash -i -c "$1 > /dev/null 2>&1; exit 0"
    xdo show $WID
elif [ "$2" = "$FZF" ]; then
    file=$(printf '%q' "`fzf`")
    xdo hide $WID
    bash -i -c "$1 $file > /dev/null 2>&1; exit 0"
    xdo show $WID
elif [ $# -eq 2 ]; then
    file2=$(printf '%q' "$2")
    xdo hide $WID
    bash -i -c "$1 $file2 > /dev/null 2>&1; exit 0"
    xdo show $WID
else
    exit 2
fi
