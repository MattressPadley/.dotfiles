#!/bin/bash

skhd_mode() {
    source "$CONFIG_DIR/colors.sh"
    source "$CONFIG_DIR/icons.sh"

    case "$MODE" in
        "Default")
            COLOR=$SKHD_DEFAULT
            ;;
        "Move")
            COLOR=$SKHD_MOVE
            ;;
        "Scratchpad")
            COLOR=$SKHD_SCRATCHPAD
            ;;
        "Focus")
            COLOR=$SKHD_FOCUS
            ;;
        *)
            COLOR=""
            ;;
    esac
    ICON=""
    [ "$MODE" = "Default" ] && LABEL="" || LABEL="$MODE"

    args=(--bar border_color=$COLOR \
          --animate sin 10 \
          --set $NAME icon.color=$COLOR \
          --set $NAME background.color=$COLOR)

    [ -z "$LABEL" ] && args+=(label.width=0) \
                    || args+=(label="$LABEL" label.width=dynamic)

    [ -z "$ICON" ] && args+=(icon.width=0) \
                    || args+=(icon="$ICON" icon.width=dynamic)

    sketchybar -m "${args[@]}"
}


case "$SENDER" in
    "skhd_mode")
        skhd_mode 
    ;;
esac
