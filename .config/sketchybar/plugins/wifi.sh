#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"
SIGNAL_STRENGTH="$(echo "$CURRENT_WIFI" | grep -o "agrCtlRSSI: .*" | sed 's/^agrCtlRSSI: //')"

echo "$SIGNAL_STRENGTH"
case "$SIGNAL_STRENGTH" in
  100) COLOR=$RED
  ;;
  8[0-9]) COLOR=$YELLOW
  ;;
  *) COLOR=$LABEL_COLOR
  ;;
esac

echo "$COLOR"
source "$CONFIG_DIR/icons.sh"
if [ "$SSID" = "" ]; then
  sketchybar --set $NAME icon=$WIFI_DISCONNECTED color=$COLOR
else
  sketchybar --set $NAME icon=$WIFI_CONNECTED color=$BASE
fi