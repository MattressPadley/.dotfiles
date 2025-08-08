#!/bin/bash

media_artwork=(
  icon.background.drawing=on
  icon.background.image.corner_radius=6
  script="$PLUGIN_DIR/media.sh"
  updates=on
  update_freq=5
  padding_left=0
  padding_right=0
  label.drawing=off
  icon.padding_right=5
)

media_track=(
  label.max_chars=20
  scroll_texts=on
  y_offset=5
  width=0
  padding_left=0
  padding_right=0
  background.drawing=off
)

media_artist=(
  label.max_chars=20
  scroll_texts=on
  y_offset=-6
  width=0
  padding_left=0
  padding_right=0
  label.color=0xff6c7086
  background.drawing=off
)

sketchybar --add item media_artwork e \
           --set media_artwork "${media_artwork[@]}" \
           --subscribe media_artwork media_change \
\
           --add item media_track e \
           --set media_track "${media_track[@]}" \
\
           --add item media_artist e \
           --set media_artist "${media_artist[@]}"

# Song update event removed - using media-control instead