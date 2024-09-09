#!/bin/sh

choice="$(
    echo "Rectangle
window
Monitor
Entire screen" |
        rofi -dmenu \
            -p "Select screenshot type" \
            -format i \
            -no-custom \
            -theme-str 'mainbox {children: [prompt, listview]; }'

)"

case "$choice" in
0)
    grim -t png -g "$(slurp)" - | swappy -f -
    ;;
1)
    info="$(hyprctl activewindow)"

    at="$(echo $info | grep -oP "at: \K\d+,\d+")"
    size="$(echo $info | grep size | sed "s/,/x/g" | grep -oP "size: \K\d+x\d+")"

    grim -g "$at $size" - | swappy -f -
    ;;
2)
    notify-send choose display
    echo grim -t png -g "$(slurp -o)" - | swappy -f -
    ;;
3)
    grim -t png - | swappy -f -
    ;;
*) ;;
esac
