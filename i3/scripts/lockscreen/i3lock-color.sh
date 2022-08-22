#!/bin/sh

# -= COLORS =-
WHITE=FFFFFF
BLACK=000000
ORANGE=FBA922
GREY=5B5B5B
GREEN=8FCE00
RED=F44336

font="inconsolata"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

i3lock-color \
  --ignore-empty-password \
  --force-clock \
  --indicator \
  --no-modkey-text \
  --color ${BLACK} \
\
  --time-str="%H:%M" \
  --date-str="%A, %d %B %Y" \
  --time-font=${FONT} \
  --date-font=${FONT} \
  --time-color=${WHITE} \
  --date-color=${WHITE} \
\
  --bar-indicator \
  --bar-max-height 5 \
  --bar-base-width 5 \
  --bar-pos -250+w/2:50+h/2 \
  --bar-count 5 \
  --bar-total-width=500 \
\
  --bar-color ${GREY} \
  --keyhl-color=${GREEN} \
  --bshl-color=${RED} \
  --verifoutline-color=${ORANGE}
#  --no-verify
