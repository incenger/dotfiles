#!/usr/bin/env bash 

# Random select a theme
configs=("$HOME/.config/polybar/simple/config.ini"  "$HOME/.config/polybar/multi_block/config.ini")

chosen_config=${configs[$RANDOM % ${#configs[@]}]}
# chosen_config=${configs[1]}

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c $chosen_config --reload mybar & 
  done
else
  polybar -c $chosen_config --reload mybar & 
  echo $chosen_config
fi

echo "Bars launched..."
