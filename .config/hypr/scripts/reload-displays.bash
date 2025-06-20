#!/bin/bash

# Reload displays
# This script is used to reload the displays in the event that they are not
# working properly. This script is for HYPRLAND.

hypr_dir="$HOME/.config/hypr"

tmpfile=$(mktemp)
mv $hypr_dir/monitors.conf "$tmpfile"
touch $hypr_dir/monitors.conf
hyprctl reload
mv "$tmpfile" $hypr_dir/monitors.conf
hyprctl reload
rm "$tmpfile"

# hyprctl dispatch dpms off
# sleep 1
# hyprctl dispatch dpms on
# hyprctl reload

# pkill -STOP Hyprland
# sleep 0.1
# pkill -CONT Hyprland

# exec $hypr_dir/scripts/lid-handling.bash check
# pkill waybar & waybar & disown

exit 0;
