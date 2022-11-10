#!/bin/bash

########################################################################
# This is a copy from another common.sh in this dir
# I add the feature that bar number can follow the change of
# active desktops, instead of showing all available desktops' numbers
########################################################################

# lemon bar color
COLOR_DEFAULT_FG="#a7a5a5"
COLOR_DEFAULT_BG="#333232"
COLOR_MONITOR_FG="#8dbcdf"
COLOR_MONITOR_BG="#333232"
COLOR_FOCUSED_MONITOR_FG="#b1d0e8"
COLOR_FOCUSED_MONITOR_BG="#144b6c"
COLOR_FREE_FG="#737171"
COLOR_FREE_BG="#333232"
COLOR_FOCUSED_FREE_FG="#000000"
COLOR_FOCUSED_FREE_BG="#504e4e"
COLOR_OCCUPIED_FG="#a7a5a5"
COLOR_OCCUPIED_BG="#333232"
COLOR_FOCUSED_OCCUPIED_FG="#d6d3d2"
COLOR_FOCUSED_OCCUPIED_BG="#504e4e"
COLOR_URGENT_FG="#f15d66"
COLOR_URGENT_BG="#333232"
COLOR_FOCUSED_URGENT_FG="#501d1f"
COLOR_FOCUSED_URGENT_BG="#d5443e"
COLOR_STATE_FG="#89b09c"
COLOR_STATE_BG="#333232"
COLOR_TITLE_FG="#f8f8f8"
COLOR_TITLE_BG="#242424"
COLOR_SYS_FG="#b1a57d"
COLOR_SYS_BG="#333232"

theme="dracula"
case $theme in
    "dracula")
        color_bg="#242424"
        color_fg="#bababa"
        color_hl1="#6272a4"
        color_hl2="#7d5bed"
        ;;
    *) # Default to Nord
        color_bg="#2e3440"
        color_fg="#eceff4"
        color_hl1="#5e81ac"
        color_hl2="#81a1c1"
        ;;
esac

bspc_desktops() {
    # make sure focused desktop is in this array
    # note: 
    # werid bash feature, sorting arrary can not be assigned back to itself in bash
    # (strange results, but in zsh, everything works fine.), 
    # therefore, I use a tmp variabel to handle this werid thing.

    # show empty desktop numbers, uncomment fowllowing 2 lines
    tmp=($(bspc query -D -d .occupied --names) $(bspc query -D -d focused --names))
    desktops=$(echo "${tmp[@]}" | tr " " "\n" | sort -u)
    
    # only show occupied desktops
    # desktops=($(bspc query -D -d .occupied --names))

    buf=""
    for d in ${desktops[@]}; do
        if [[ "$(bspc query -D -d focused --names)" == "${d}" ]]; then
            # focused occupied desktop
            FG=$COLOR_FOCUSED_OCCUPIED_FG
            BG=$COLOR_FOCUSED_OCCUPIED_BG
            UL=$BG
			buf="${buf}%{F${FG}}%{B${BG}}%{U${UL}}%{+u} ${d} %{B-}%{F-}%{-u}"
        else
            buf="${buf}%{+u} ${d} %{-u}"
        fi
    done

    echo "${buf}"
}
