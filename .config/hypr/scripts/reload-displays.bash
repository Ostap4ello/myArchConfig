#!/bin/bash

# Reload displays
# This script is used to reload the displays in the event that they are not
# working properly. This script is for HYPRLAND.

mv $HOME/.config/hypr/monitors.conf $HOME/.config/hypr/monitors.conf.bak
touch $HOME/.config/hypr/monitors.conf # Touch the file to avoid errors
hyprctl reload
mv $HOME/.config/hypr/monitors.conf.bak $HOME/.config/hypr/monitors.conf
hyprctl reload
pkill -STOP Hyprland
pkill -CONT Hyprland
