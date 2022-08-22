#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

wallpaperPath="$SCRIPT_DIR/StarTrek-Lockscreen.png"

color=F1DF6FFF
textPos=1066:900
indicatorPos=1066:434

dateSize=20
timeSize=25
batSize=50

greetFont="inconsolata"

batLvl=$(eval cat /sys/class/power_supply/BAT0/capacity)"%"

i3lock-color \
    --image=${wallpaperPath}\
    --tiling \
    --ignore-empty-password \
    --force-clock \
    --time-str="%H:%M" \
    --time-color=${color} \
    --time-size=${timeSize} \
    --date-str="%d/%m/%y" \
    --date-color=${color} \
    --date-size=${dateSize} \
    --time-pos="632:1025" \
    --date-pos="632:1060" \
    --nofork \
    --lockfailed-text="Failed to lock... Try again" \
    --noinput-text="" \
    --verif-color=ACAEE8FF \
    --verif-pos=${textPos} \
    --verif-text="Checking Starfleet identity..." \
    --wrong-color=FF0000FF \
    --wrong-pos=${textPos} \
    --wrong-text="Logging failed... RED ALERT!" \
    --ind-pos=${indicatorPos} \
    --radius=146 \
    --ring-color=${color} \
    --inside-color=00000000 \
    --lock-text="" \
    --greeter-color=${color} \
    --greeter-size=${batSize} \
    --greeter-pos="140:820" \
    --greeter-font=${greetFont} \
    --greeter-text="${batLvl}" \
    --redraw-thread
