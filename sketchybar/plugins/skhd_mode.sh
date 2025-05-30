#!/bin/sh

if [ "$SENDER" = "skhd_launch_mode_toggled" ]; then
  if [ "$MODE" = "on" ]; then
    echo "launch mode"
    sketchybar --set "$NAME" label="[LAUNCH]"
  else
    echo "default"
    sketchybar --set "$NAME" label=""
  fi
  #sketchybar --set "$NAME" label="${FRONT_APP}*"
fi
