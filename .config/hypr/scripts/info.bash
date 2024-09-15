#!/bin/sh

rofi \
    -theme-str '* {font: "JuliaMono 8";}' \
    -e "$(cat ~/.config/hypr/scripts/hints.txt)"
