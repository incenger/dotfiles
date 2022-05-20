#!/bin/bash

if [ -z "$@" ]; then
    echo -en "Extended (Right)\n"
    echo -en "Extended (Left)\n"
    echo -en "Mirror\n"
    echo -en "eDP1\n"
else
    if [ "$1" = "eDP1" ]; then
        sh ~/.screenlayout/edp1.sh &> /dev/null & disown;
    elif [ "$1" = "Mirror" ]; then
        sh ~/.screenlayout/mirror.sh &> /dev/null & disown;
    elif [ "$1" = "Extended (Right)" ]; then
        sh ~/.screenlayout/home_layout_right.sh &> /dev/null & disown;
    elif [ "$1" = "Extended (Left)" ]; then
        sh ~/.screenlayout/home_layout_left.sh &> /dev/null & disown;
    fi
fi
