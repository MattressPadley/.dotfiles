#!/bin/sh

printf "INFO: $INFO\n"

case "$INFO" in
  "DaVinci Resolve") sketchybar --bar hidden=on
    ;;
  *) sketchybar --bar hidden=off
esac