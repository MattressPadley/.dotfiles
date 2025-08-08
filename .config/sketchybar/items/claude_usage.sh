#!/usr/bin/env sh

# Claude Usage Monitor - Three stacked rows like CPU/RAM/Network stats
# Each row: LABEL | [BAR] | VALUE

# Add items in reverse order for proper right-side stacking
# Bottom row: PROJECTION
sketchybar --add item claude_usage.projection_value right \
  --set claude_usage.projection_value \
  label.font="$FONT2:Regular:8.0" \
  label="0%" \
  label.color=$YELLOW \
  icon.drawing=off \
  y_offset=-10 \
  width=0 \
  padding_left=0 \
  padding_right=4 \
  display=1 \
  \
  --add item claude_usage.projection_bar right \
  --set claude_usage.projection_bar \
  label.font="FiraCode Nerd Font:Regular:8" \
  label="░░░░░░░░░░" \
  label.color=$YELLOW \
  icon.drawing=off \
  y_offset=-10 \
  width=0 \
  padding_left=0 \
  padding_right=24 \
  display=1 \
  \
  --add item claude_usage.projection_label right \
  --set claude_usage.projection_label \
  label.font="$FONT2:Regular:8.0" \
  label="PROJ" \
  label.color=$YELLOW \
  icon.drawing=off \
  y_offset=-10 \
  width=0 \
  padding_left=0 \
  padding_right=76 \
  display=1 \
  \
  --add item claude_usage.usage_value right \
  --set claude_usage.usage_value \
  label.font="$FONT2:Regular:8.0" \
  label="0%" \
  label.color=$GREEN \
  icon.drawing=off \
  y_offset=0 \
  width=0 \
  padding_left=0 \
  padding_right=4 \
  display=1 \
  \
  --add item claude_usage.usage_bar right \
  --set claude_usage.usage_bar \
  label.font="FiraCode Nerd Font:Regular:8" \
  label="░░░░░░░░░░" \
  label.color=$GREEN \
  icon.drawing=off \
  y_offset=0 \
  width=0 \
  padding_left=0 \
  padding_right=24 \
  display=1 \
  \
  --add item claude_usage.usage_label right \
  --set claude_usage.usage_label \
  label.font="$FONT2:Regular:8.0" \
  label="USAGE" \
  label.color=$GREEN \
  icon.drawing=off \
  y_offset=0 \
  width=0 \
  padding_left=0 \
  padding_right=76 \
  display=1 \
  \
  --add item claude_usage.session_value right \
  --set claude_usage.session_value \
  label.font="$FONT2:Regular:8.0" \
  label="14:00" \
  label.color=$BLUE \
  icon.drawing=off \
  y_offset=10 \
  width=0 \
  padding_left=0 \
  padding_right=4 \
  display=1 \
  \
  --add item claude_usage.session_bar right \
  --set claude_usage.session_bar \
  label.font="FiraCode Nerd Font:Regular:8" \
  label="░░░░░░░░░░" \
  label.color=$BLUE \
  icon.drawing=off \
  y_offset=10 \
  width=0 \
  padding_left=0 \
  padding_right=24 \
  display=1 \
  \
  --add item claude_usage.session_label right \
  --set claude_usage.session_label \
  label.font="$FONT2:Regular:8.0" \
  label="SESSION" \
  label.color=$BLUE \
  icon.drawing=off \
  y_offset=10 \
  width=0 \
  padding_left=0 \
  padding_right=76 \
  display=1 \
  update_freq=5 \
  script="$PLUGIN_DIR/claude_usage.sh"
