#!/bin/bash


if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
    echo -en "Logout\0icon\x1fsystem-log-out\n"
    echo -en "Suspend\0icon\x1fsystem-suspend\n"
    echo -en "Reboot\0icon\x1fsystem-restart\n"
else
    if [ "$1" = "Shutdown" ]; then
        shutdown now
    elif [ "$1" = "Exit" ]; then
        i3exit logout
    elif [ "$1" = "Reboot" ]; then
        shutdown --reboot now
    elif [ "$1" = "Suspend" ]; then
        system-ctl suspend
    fi
fi
