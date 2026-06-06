#!/bin/sh

LABEL=""
STATE=$(osascript -e 'tell application "System Events" to (name of first process whose frontmost is true)')

case "$STATE" in
  "Music"|"Spotify")
    TRACK=$(osascript -e "
      tell application \"$STATE\"
        if player state is playing then
          set t to name of current track
          set a to artist of current track
          return t & \" — \" & a
        else
          return \"\"
        end if
      end tell
    " 2>/dev/null)
    if [ -n "$TRACK" ]; then
      LABEL="$TRACK"
    fi
    ;;
esac

if [ -z "$LABEL" ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" drawing=on icon= label="$LABEL"
fi
