#!/bin/bash

# Create temp directory for artwork if it doesn't exist
ARTWORK_DIR="/tmp/sketchybar_media_artwork"
mkdir -p "$ARTWORK_DIR"

update_media() {
  # Get current media info from media-control
  MEDIA_INFO=$(media-control get 2>/dev/null)
  
  if [ $? -eq 0 ] && [ -n "$MEDIA_INFO" ]; then
    # Parse the JSON output
    STATE=$(echo "$MEDIA_INFO" | jq -r '.playbackRate // empty')
    TITLE=$(echo "$MEDIA_INFO" | jq -r '.title // empty')
    ARTIST=$(echo "$MEDIA_INFO" | jq -r '.artist // empty')
    ARTWORK_DATA=$(echo "$MEDIA_INFO" | jq -r '.artworkData // empty')
    ARTWORK_MIME=$(echo "$MEDIA_INFO" | jq -r '.artworkMimeType // empty')
    
    
    # Get album name
    ALBUM=$(echo "$MEDIA_INFO" | jq -r '.album // empty')
    
    # Check if media is playing (playbackRate > 0)
    if [ -n "$STATE" ] && [ "$STATE" != "0" ] && [ -n "$TITLE" ]; then
      # Handle artwork
      ARTWORK_PATH="$ARTWORK_DIR/current_artwork"
      if [ -n "$ARTWORK_DATA" ] && [ "$ARTWORK_DATA" != "null" ]; then
        # Determine file extension from MIME type
        case "$ARTWORK_MIME" in
          "image/jpeg") ARTWORK_EXT="jpg" ;;
          "image/png") ARTWORK_EXT="png" ;;
          "image/webp") ARTWORK_EXT="webp" ;;
          *) ARTWORK_EXT="jpg" ;;  # Default to jpg
        esac
        
        ARTWORK_FILE="$ARTWORK_PATH.$ARTWORK_EXT"
        
        # Decode base64 artwork data and save to file
        echo "$ARTWORK_DATA" | base64 --decode > "$ARTWORK_FILE" 2>/dev/null
        
        if [ -f "$ARTWORK_FILE" ]; then
          # Resize the artwork to fit the bar (32x32 pixels)
          RESIZED_FILE="$ARTWORK_PATH.resized.$ARTWORK_EXT"
          sips -z 32 32 "$ARTWORK_FILE" --out "$RESIZED_FILE" >/dev/null 2>&1
          
          if [ -f "$RESIZED_FILE" ]; then
            sketchybar --set media_artwork icon.background.image="$RESIZED_FILE" drawing=on
          else
            sketchybar --set media_artwork icon.background.image="$ARTWORK_FILE" drawing=on
          fi
        else
          sketchybar --set media_artwork drawing=on
        fi
      else
        # No artwork available
        sketchybar --set media_artwork drawing=on
      fi
      
      # Update track and artist labels
      sketchybar --set media_track label="$TITLE" drawing=on
      if [ -n "$ARTIST" ] && [ -n "$ALBUM" ]; then
        sketchybar --set media_artist label="$ARTIST • $ALBUM" drawing=on
      elif [ -n "$ARTIST" ]; then
        sketchybar --set media_artist label="$ARTIST" drawing=on
      elif [ -n "$ALBUM" ]; then
        sketchybar --set media_artist label="$ALBUM" drawing=on
      else
        sketchybar --set media_artist drawing=off
      fi
    else
      sketchybar --set media_artwork drawing=off
      sketchybar --set media_track drawing=off
      sketchybar --set media_artist drawing=off
    fi
  else
    # No media playing or media-control failed
    sketchybar --set media_artwork drawing=off
    sketchybar --set media_track drawing=off
    sketchybar --set media_artist drawing=off
  fi
}

case "$SENDER" in
  "media_change") 
    echo "media_change event received" >&2
    update_media
    ;;
  "song_update") 
    echo "song_update event received" >&2
    update_media
    ;;
  *)
    echo "Unknown sender: $SENDER" >&2
    update_media
    ;;
esac
