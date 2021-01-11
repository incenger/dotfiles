#!/bin/bash

if [ -z "$@" ]; then
    echo -en "eDP1\n"
    echo -en "Mirror\n"
    echo -en "Home\n"
else
    if [ "$1" = "eDP1" ]; then
        sh ~/.screenlayout/edp1.sh &> /dev/null & disown;
    elif [ "$1" = "Mirror" ]; then
        sh ~/.screenlayout/mirror.sh &> /dev/null & disown;
    elif [ "$1" = "Home" ]; then
        sh ~/.screenlayout/home_layout.sh &> /dev/null & disown;
    fi
fi
