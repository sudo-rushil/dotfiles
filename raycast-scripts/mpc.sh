#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title mpc
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎵

# Documentation:
# @raycast.description Control music
# @raycast.author sudo-rushil
# @raycast.argument1 { "type": "dropdown", "placeholder": "action", "data": [{"title": "toggle", "value": "toggle"}, {"title": "prev", "value": "prev"}, {"title": "next", "value": "next"}, {"title": "stop", "value": "stop"} ]}

mpc $1
