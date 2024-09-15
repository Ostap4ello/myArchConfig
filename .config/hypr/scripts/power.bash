#!/bin/sh

choice="$(
    echo "1   reboot
2   poweroff
3   hibernate
4   suspend
5   lock" |
        rofi -dmenu \
            -p "Power Menu" \
            -format i \
            -no-custom \
            -theme-str 'entry { enabled: false;}'
)"

case "$choice" in
0)
    reboot
    ;;
1)
    systemctl poweroff
    ;;
2)
    hyprlock &
    disown && systemctl hibernate

    ;;
3)
    hyprlock &
    disown && systemctl suspend
    ;;
4)
    hyprlock
    ;;
*) ;;
esac
