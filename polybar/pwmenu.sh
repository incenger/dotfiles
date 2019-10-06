#!/bin/bash

# Created By Aditya Shakya

MENU="$(rofi -sep "|" -dmenu -i -p 'System' -location 3 -yoffset 25 -width 12 -hide-scrollbar -line-padding 4 -padding 20 -lines 5 -font <<< " Lock| Logout|鈴 Suspend| Reboot| Shutdown")"
            case "$MENU" in
                *Lock) i3lock-fancy --font "Ringbearer-Medium" --text "YOU SHALL NOT PASS";;
                *Logout) i3exit logout;;
                *Suspend) i3exit suspend;;
                *Reboot) systemctl reboot ;;
                *Shutdown) systemctl -i poweroff;;
            esac
