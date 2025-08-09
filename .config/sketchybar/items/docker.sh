#!/usr/bin/env sh

docker_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BAR_BORDER_COLOR
  background.border_width=1
)

sketchybar --add item        docker.ram right                     \
           --set docker.ram  label.font="$FONT2:Regular:9.0"    \
                             label.color=$BLUE                   \
                             y_offset=-6                         \
                             width=0                            \
                             update_freq=5                       \
                             padding_left=2                      \
                             padding_right=5                     \
                                                                 \
           --add item        docker.cpu right                    \
           --set docker.cpu  label.font="$FONT2:Regular:9.0"    \
                             label.color=$YELLOW                 \
                             y_offset=5                          \
                             width=32                             \
                             update_freq=5                       \
                             padding_left=2                      \
                             padding_right=5                     \
                                                                 \
           --add item        docker.count right                 \
           --set docker.count icon.drawing=off                  \
                             label.font="$FONT:Semibold:13.0"   \
                             label.color=$LABEL_COLOR            \
                             label="Loading..."                  \
                             update_freq=5                       \
                             script="$PLUGIN_DIR/docker.sh"     \
                             padding_left=0                      \
                             padding_right=5                     \
                                                                 \
           --add item        docker.icon right                   \
           --set docker.icon icon="$($CONFIG_DIR/icon_map.sh "Docker")"              \
                             icon.font="sketchybar-app-font:Regular:16.0" \
                             icon.color=$ICON_COLOR              \
                             label.drawing=off                   \
                             popup.align=right                   \
                             click_script="$PLUGIN_DIR/docker_click.sh" \
                             padding_left=5                      \
                             padding_right=0                     \
           --subscribe docker.icon mouse.entered                 \
                             mouse.exited                        \
                             mouse.exited.global

sketchybar --add bracket docker_group docker.ram docker.cpu docker.count docker.icon \
           --set docker_group "${docker_bracket[@]}"
