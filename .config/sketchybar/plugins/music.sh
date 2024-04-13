#!/bin/bash

update_media(){
  APP_STATE=$(pgrep -x Music)
  if [[ ! $APP_STATE ]]; then 
    sketchybar -m --set music_liked drawing=off
    exit 0
  fi


  PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
  if [[ $PLAYER_STATE == "paused" ]]; then
    sketchybar -m --set music_liked drawing=off
    exit 0
  fi
  if [[ $PLAYER_STATE == "stopped" ]]; then
    sketchybar -m --set music_liked drawing=off
    exit 0
  fi



  LOVED=$(osascript -l JavaScript -e "Application('Music').currentTrack().favorited()")

  if [[ $LOVED == "true" ]]; then
    ICON=􀋃
  else
    ICON=􀋂
  fi

  sketchybar -m --set music_liked icon="$ICON"\
                --set music_liked drawing=on
}

case "$SENDER" in
  "media_change") update_media
  ;;
  "song_update") update_media
  ;;
esac
