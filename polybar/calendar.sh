#! /bin/sh
year=$(date '+%Y')
month=$(date '+%m')
date=$(date '+%A, %d %B')
# (( month == 12 )) && month=1 && year=$((year + 1)) || month=$((month + 1))
# date=$(cal $month $year | sed -n '1s/^  *//;1s/  *$//p')

export TERM=urxvt
cal --color=always \
    | tail -n +2 \
    | rofi \
    -i \
    -dmenu \
    -location 2 \
    -padding 20 \
    -line-padding 1\
    -yoffset 25\
    -width 14\
    -lines 6 \
    -hide-scrollbar \
    -p "Calendar" > /dev/null 
