#!/usr/bin/bash
#
# Script to execute a command with optional file selection via fzf or direct argument.
# Hides the current window during execution and restores it afterward.
#
# Usage:
#   run_with_fzf.sh <command> [filename|fzf]
#
# Arguments:
#   - $1: The command to execute (required)
#   - $2: Optional. Either a filename or the string "fzf" to trigger fuzzy file selection
#
# Dependencies:
#   - fzf: Fuzzy finder (used if second argument is "fzf")
#   - xdo: From the `xdotool` package, used to hide/show the current window
#
# Notes:
#   - When no arguments are given, the script will print an error message.
#   - When only one argument is provided, it runs the command directly.
#   - If the second argument is "fzf", opens a fuzzy finder to choose a file.
#   - Otherwise, treats the second argument as a literal filename.
#   - All command output is suppressed (redirected to /dev/null).
#

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
