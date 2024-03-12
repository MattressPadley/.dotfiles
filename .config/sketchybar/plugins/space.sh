#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  if [ $SELECTED = true ]; then
    sketchybar --set $NAME background.drawing=on \
                          background.color=$HIGHLIGHT_COLOR \
                          label.color=$LABEL_HIGHLIGHT_COLOR \
                          icon.color=$ICON_HIGHLIGHT_COLOR
  else
    sketchybar --set $NAME background.drawing=on \
                          label.color=$LABEL_COLOR \
                          icon.color=$ICON_COLOR\
                          background.border_color=$HIGHLIGHT_COLOR\
                          background.color=$BACKGROUND_1\
                          background.border_width=1
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      yabai -m space --focus $SID 2>/dev/null
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac