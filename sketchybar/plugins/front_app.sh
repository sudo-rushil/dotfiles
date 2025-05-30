#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  FRONT_APP="$INFO"
  sketchybar --set "$NAME" label="$INFO"
fi

if [ "$SENDER" = "skhd_launch_mode_toggled" ]; then
  if [ "$MODE" = "on" ]; then
    #echo "launch mode"
    sketchybar --set "$NAME" label="${FRONT_APP}*"
  else
    #echo "default"
    sketchybar --set "$NAME" label="${FRONT_APP}"
  fi
  #sketchybar --set "$NAME" label="${FRONT_APP}*"
fi



