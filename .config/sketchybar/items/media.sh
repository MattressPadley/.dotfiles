#!/bin/bash

media=(
  icon.background.drawing=on
  icon.background.image=media.artwork
  icon.background.image.corner_radius=6
  script="$PLUGIN_DIR/media.sh"
  label.max_chars=15
  scroll_texts=on
  updates=on
)

music_liked=(
    icon=
    script="$PLUGIN_DIR/music.sh"
    click_script="$PLUGIN_DIR/music_click.sh"
    updates=on
)

sketchybar --add item media center \
           --set media "${media[@]}" \
           --subscribe media media_change

sketchybar -m --add event song_update com.apple.iTunes.playerInfo
sketchybar --add item music_liked center \
           --set music_liked "${music_liked[@]}"\
           --subscribe music_liked media_change