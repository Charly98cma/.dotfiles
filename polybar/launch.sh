#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
killall .polybar-wrappe
# Otherwise you can use the nuclear option:
# killall -q polybar

CONFIG_DIR=${HOME}/.dotfiles/polybar/config.ini

# Launching top and bottom bars on each monitor
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$CONFIG_DIR top 2>&1 | tee -a /tmp/polybar1.log & disown
    MONITOR=$m polybar --config=$CONFIG_DIR bottom 2>&1 | tee -a /tmp/polybar2.log & disown
  done
fi



echo "Bars launched..."
