#!/bin/sh

# Copied from https://github.com/nguyenvulong/devenv-macos/blob/main/.config/sketchybar/plugins/weather.sh

ENDPOINT='https://aviationweather.gov/api/data/metar?ids=KBOS&format=json&taf=false&hours=2'

WEATHER_DATA=$(curl -s -m 5 ${ENDPOINT} | jq '.[] | select(.mostRecent == 1).rawOb' | tr -d '"')
CURL_STATUS=$?

WEATHER_ICON=""

#WEATHER_DATA=$(curl -s -m 5 "wttr.in/NYC?format=%l:+%t+%m,%c")
#WEATHER_ICON=$(echo $WEATHER_DATA | cut -d, -f2 | xargs)
#WEATHER_LABEL=$(echo $WEATHER_DATA | cut -d, -f1 | xargs)

if [ $CURL_STATUS -eq 0 ] && [ -n "$WEATHER_DATA" ]; then
  sketchybar --set "$NAME" icon="${WEATHER_ICON}" \
             label="${WEATHER_DATA}" \
             label.max_chars=20 \
             label.scroll_duration=140 \
             scroll_texts=on
fi
