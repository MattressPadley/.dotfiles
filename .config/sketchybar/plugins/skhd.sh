#!/bin/bash

skhd_mode() {
    source "$CONFIG_DIR/colors.sh"
    source "$CONFIG_DIR/icons.sh"

    case "$MODE" in
        "Default")
            COLOR=$SKHD_DEFAULT
            ;;
        "Scratchpad")
            COLOR=$SKHD_SCRATCHPAD
            ;;
        "Window")
            COLOR=$SKHD_WINDOW
            ;;
        "Restart")
            COLOR=$SKHD_RESTART
            ;;
        *)
            COLOR=""
            ;;
    esac
    ICON=""
    [ "$MODE" = "Default" ] && LABEL="" || LABEL="$MODE"

    args=(--bar border_color=$COLOR \
          --animate sin 10 \
          --set $NAME background.color=$COLOR)

    [ -z "$LABEL" ] && args+=(label.width=0) \
                    || args+=(label="$LABEL" label.width=dynamic)

    sketchybar -m "${args[@]}"
}


case "$SENDER" in
    "skhd_mode")
        skhd_mode 
    ;;
esac
