#!/bin/bash

# Reload displays
# This script is used to reload the displays in the event that they are not
# working properly. This script is for HYPRLAND.

hypr_dir="$HOME/.config/hypr"

mv $hypr_dir/monitors.conf $hypr_dir/monitors.conf.bak
touch $hypr_dir/monitors.conf
hyprctl reload
mv $hypr_dir/monitors.conf.bak $hypr_dir/monitors.conf
hyprctl reload

pkill -STOP Hyprland
sleep 0.1
pkill -CONT Hyprland

exec $hypr_dir/scripts/lid-handling.bash check
pkill waybar & waybar & disown

exit 0;
