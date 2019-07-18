#!/bin/bash

# Created By Aditya Shakya

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -yoffset 25 -width 12 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 -font <<< " Lock| Logout| Reboot| Shutdown")"
            case "$MENU" in
                *Lock) i3lock-fancy --font "Ringbearer-Medium" --text "YOU SHALL NOT PASS";;
                *Logout) i3exit logout;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff
            esac
