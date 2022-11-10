#!/bin/bash

cd $(dirname -- $0)

. ./common2.sh

desktop="$(bspc_desktops)"

while read -r line; do
    case $line in
        DAT*)
            # date="%{B${color_hl1}}   ${line#???}   %{B-}"
            date="${line#???}"
            ;;
        DES*)
            desktop="${line#???}"
            ;;
        # BRI*)
        #     brightness="\uf0eb ${line#???}"
        #     ;;
        VOL*)
            volume="${line#???}"
            ;;
        BAT*)
            battery="\uf578${line#???}"
            ;;
        *) ;;
    esac

    title="Command Line Heroes"
    title="%{F$COLOR_TITLE_FG}%{B$COLOR_TITLE_BG} ${title} %{B-}%{F-}"
    echo -e "%{l}${desktop} %{c} %{r}${date}"
done
