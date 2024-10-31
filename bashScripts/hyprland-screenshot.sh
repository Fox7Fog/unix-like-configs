#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  -f, --full     Capture full screen"
    echo "  -s, --select   Capture selected area"
    echo "  -w, --window   Capture active window"
    echo "  -h, --help     Show this help message"
}

# Function to capture full screen
capture_full() {
    grim - | wl-copy
    notify-send "Screenshot captured" "Full screen screenshot has been copied to clipboard"
}

# Function to capture selected area
capture_selection() {
    grim -g "$(slurp)" - | wl-copy
    notify-send "Screenshot captured" "Area screenshot has been copied to clipboard"
}

# Function to capture active window
capture_window() {
    active_window=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
    grim -g "$active_window" - | wl-copy
    notify-send "Screenshot captured" "Active window screenshot has been copied to clipboard"
}

# Parse command line arguments
case "$1" in
    -f|--full)
        capture_full
        ;;
    -s|--select)
        capture_selection
        ;;
    -w|--window)
        capture_window
        ;;
    -h|--help)
        show_help
        ;;
    *)
        show_help
        exit 1
        ;;
esac

# Save the screenshot to a file
# grim ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png
