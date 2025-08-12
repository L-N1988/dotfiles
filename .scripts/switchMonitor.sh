#! /bin/sh

internal_monitor=eDP1
external_monitor=DP1
res_1080p='1920x1080'
res_2k='2560x1440'
res_4k='3840x2160'

monitor_add() {
	# Number of desktop(s) to be moved to the second monitor
	desktop=4

	for desktop in $(bspc query -D -m $internal_monitor | sed "$desktop"q)
	do
		bspc desktop $desktop --to-monitor $external_monitor
	done

	bspc desktop Desktop --remove
}

monitor_remove() {
	# Temp desktop because one desktop requited per monitor
	bspc monitor $internal_monitor -a Desktop

	# Move everything to external monitor to reorder desktops
	for desktop in $(bspc query -D -m $internal_monitor)
	do
		bspc desktop $desktop --to-monitor $external_monitor
	done

	# Move everything back to internal monitor
	bspc monitor $external_monitor -a Desktop # Temp desktop

	for desktop in $(bspc query -D -m  $external_monitor)
	do
		bspc desktop $desktop --to-monitor $internal_monitor
	done

	bspc desktop Desktop --remove
}


if [[ $(xrandr -q | grep -w 'DP1 connected') ]]; then
	pkill polybar
	# monitor_add
	xrandr --output eDP1 --primary --mode 2160x1440 --rotate normal --output DP1 --mode $res_4k --rotate normal --right-of eDP1
	bspc monitor eDP1 -d 1 2
	bspc monitor DP1 -d 3 4 5 6 7 8 9 0
else
	# monitor_remove
	bspc monitor eDP1 -d 1 2 3 4 5 6 7 8 9 0
fi

$HOME/.config/polybar/launch.sh &
# feh --bg-fill ~/Pictures/MIT.webp
feh --bg-center ~/Pictures/true_detective.webp
