#!/bin/bash

update_media(){
  # Get current media info from media-control
  MEDIA_INFO=$(media-control get 2>/dev/null)
  
  if [ $? -ne 0 ] || [ -z "$MEDIA_INFO" ]; then
    sketchybar -m --set music_liked drawing=off
    exit 0
  fi

  # Check if media is playing (playbackRate > 0)
  STATE=$(echo "$MEDIA_INFO" | jq -r '.playbackRate // empty')
  if [ -z "$STATE" ] || [ "$STATE" = "0" ]; then
    sketchybar -m --set music_liked drawing=off
    exit 0
  fi

  # Check if it's Music app using multiple methods
  APP=$(echo "$MEDIA_INFO" | jq -r '.app // empty')
  BUNDLE_ID=$(echo "$MEDIA_INFO" | jq -r '.bundleIdentifier // empty')
  IS_MUSIC_APP=$(echo "$MEDIA_INFO" | jq -r '.isMusicApp // false')
  
  # Only show liked status for Music app
  if [[ "$APP" == "Music" ]] || [[ "$BUNDLE_ID" == "com.apple.Music" ]] || [[ "$IS_MUSIC_APP" == "true" ]]; then
    # Try to get favorited status via AppleScript as fallback
    LOVED=$(osascript -l JavaScript -e "Application('Music').currentTrack().favorited()" 2>/dev/null)

    if [[ $LOVED == "true" ]]; then
      ICON=􀋃
    else
      ICON=􀋂
    fi

    sketchybar -m --set music_liked icon="$ICON"\
                  --set music_liked drawing=on
  else
    # For other apps, just hide the liked indicator
    sketchybar -m --set music_liked drawing=off
  fi
}

case "$SENDER" in
  "media_change") update_media
  ;;
  "song_update") update_media
  ;;
esac
