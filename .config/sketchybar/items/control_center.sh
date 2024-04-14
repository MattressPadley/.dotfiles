sketchybar --query default_menu_items
sketchybar -m  --add alias "Control Center,WiFi" right                    \
           --set    "Control Center,WiFi" update_freq=3                                 \
                                          icon.drawing=off\
                                          alias.color=$ICON_COLOR                             \
                                          label.drawing=off                             \
                                          click_script="sketchybar -m --set \"\$NAME\" popup.drawing=toggle; sketchybar --trigger wifi" \
                                                                                        \
           --add       item               wifi.details popup."Control Center,WiFi"      \
           --set       wifi.details       updates=on                                    \
                                          script="$PLUGIN_DIR/wifi.sh"                  \
                                          label.padding_right=5                         \
           --subscribe wifi.details       wifi             