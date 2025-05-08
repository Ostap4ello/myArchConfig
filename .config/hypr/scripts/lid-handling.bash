#
#!/bin/sh
#

# TODO: when lid is closed and external monitor gets disconnected

zeile="monitor=desc:AU Optronics 0xE495,disable"
monitorCnt=$(hyprctl monitors | grep "Monitor" | wc -l);
hypr_dir="$HOME/.config/hypr";
lidstate_file="/proc/acpi/button/lid/LID0/state";

function handle_lid() {
    local state=$1;
    if [[ "$state" == "open" ]]; then
        sed -i "/$zeile/d" $hypr_dir/monitors.conf;
    elif [[ "$state" == "close" ]]; then
        if [[ $monitorCnt -eq 1 ]]; then
            echo "No external monitors connected. Exiting.";
            return 0;
        fi
        grep -Fq "$zeile" $hypr_dir/monitors.conf || \
            echo "$zeile" >> $hypr_dir/monitors.conf
    fi
}

function usage() {
    echo "Usage: $0 [open|close|check]";
    exit 1;
}

# main
if [[ "$1" == "open" ]]; then
    handle_lid "open";
elif [[ "$1" == "close" ]]; then
    handle_lid "close";
elif [[ "$1" == "check" ]]; then
    if [[ $(cat $lidstate_file | awk '{print $2}') == "open" ]]; then
        handle_lid "open";
    else
        handle_lid "close";
    fi
else
    usage;
fi

echo "[$(date)]: Lid is $(cat $lidstate_file) \
    " >> ~/.lidlog;
exit 0;
