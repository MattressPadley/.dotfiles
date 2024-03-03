#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]
  then
    # No argument provided, use today's date
    today=$(date +%Y-%m-%d)
    log_file="logs/$today.log"
  else
    # Argument provided, use the specified log file
    log_file="$1"
  fi

# Run lnav with the specified log file
lnav "$log_file"
